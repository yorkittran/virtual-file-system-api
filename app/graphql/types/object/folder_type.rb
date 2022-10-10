module Types
  module Object
    class FolderType < BaseObject
      field :id, ID
      field :name, String
      field :created_at, Int

      def created_at
        object.created_at.to_s
      end
    end
  end
end
