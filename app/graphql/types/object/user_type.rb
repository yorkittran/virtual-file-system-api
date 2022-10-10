module Types
  module Object
    class UserType < BaseObject
      field :id, ID
      field :email, String, null: false
      field :root_folder, FolderType
    end
  end
end
