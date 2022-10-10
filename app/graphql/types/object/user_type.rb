module Types
  module Object
    class UserType < BaseObject
      field :id, ID
      field :email, String, null: false
    end
  end
end
