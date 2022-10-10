# == Schema Information
#
# Table name: files
#
#  id          :bigint(8)        not null, primary key
#  folder_id   :bigint(8)        not null
#  name        :string(255)      not null
#  data        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_files_on_folder_id  (folder_id)
#
class File < ApplicationRecord
  belongs_to :folder
end
