module Mutations
  module Users
    class RegisterMutation < BaseMutation
      graphql_name 'Register'

      argument :email, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true

      field :access_token, String
      field :user, Types::Object::UserType

      def resolve(args)
        args[:authentication_token] = SecureRandom.hex
        user = User.create!(args)
        user.folders.create!(name: ::Folder::ROOT_NAME)
        access_token = JsonWebToken.encode(id: user.id, authentication_token: user.authentication_token)
        context[:current_user] = user

        { user: , access_token: }
      end
    end
  end
end
