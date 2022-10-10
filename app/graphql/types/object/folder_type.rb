module Types
  module Object
    class FolderType < BaseObject
      field :id, ID
      field :type, String
      field :name, String
      field :size, Int
      field :created_at, String

      def type
        object.class
      end

      def created_at
        object.created_at.to_s
      end
    end
  end
end
