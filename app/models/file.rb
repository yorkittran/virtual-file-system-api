# == Schema Information
#
# Table name: files
#
#  id          :bigint(8)        not null, primary key
#  folder_id   :bigint(8)        not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_files_on_folder_id  (folder_id)
#
class File < ApplicationRecord
  has_one_attached :file

  belongs_to :folder
end
