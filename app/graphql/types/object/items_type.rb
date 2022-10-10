module Types
  module Object
    class ItemsType < BaseObject
      field :folders, [FolderType]
      field :system_files, [SystemFileType]

      def folders
        object.children
      end

      def system_files
        object.system_files
      end
    end
  end
end
