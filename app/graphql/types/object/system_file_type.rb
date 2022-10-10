module Types
  module Object
    class SystemFileType < BaseObject
      field :id, ID
      field :type, String
      field :name, String
      field :data, String
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
