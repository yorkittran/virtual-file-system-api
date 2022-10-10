# == Schema Information
#
# Table name: system_files
#
#  id         :bigint(8)        not null, primary key
#  folder_id  :bigint(8)        not null
#  name       :string(255)      not null
#  data       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_system_files_on_folder_id  (folder_id)
#
# Foreign Keys
#
#  fk_rails_...  (folder_id => folders.id)
#
class SystemFile < ApplicationRecord
  belongs_to :folder

  validates :name, presence: true, uniqueness: { scope: :folder_id }

  def size
    data.length
  end
end
