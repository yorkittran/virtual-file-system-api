# == Schema Information
#
# Table name: folders
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)      not null
#  ancestry   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_folders_on_ancestry  (ancestry)
#
class Folder < ApplicationRecord
  has_ancestry

  has_many :system_files, dependent: :destroy

  validates :name, presence: true, format: { with: /\A[a-zA-Z0-9 _-]+\z/ }, uniqueness: { scope: :ancestry }

  ROOT_NAME = 'root'

  def self.root
    self.find_or_create_by!(name: ROOT_NAME)
  end

  def size
    system_files.sum(&:size)
  end
end
