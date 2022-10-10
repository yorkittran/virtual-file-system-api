module Types
  module Object
    class FolderType < BaseObject
      field :id, ID
      field :name, String
      field :created_at, String

      def created_at
        object.created_at.to_s
      end
    end
  end
end
