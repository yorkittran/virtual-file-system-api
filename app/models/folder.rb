# == Schema Information
#
# Table name: folders
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)        not null
#  name       :string(255)      not null
#  ancestry   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_folders_on_ancestry  (ancestry)
#  index_folders_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Folder < ApplicationRecord
  ROOT_NAME = 'root'

  has_ancestry

  belongs_to :user
  has_many :system_files, dependent: :destroy

  validates :name, presence: true, format: { with: /\A[a-zA-Z0-9 _-]+\z/ }, uniqueness: { scope: :ancestry }

  scope :by_user, -> (user) { where(user: user) }

  def self.root
    self.find_or_create_by!(name: ROOT_NAME)
  end

  def size
    system_files.sum(&:size)
  end
end
