require 'json_web_token'

module Mutations
  module Users
    class SignInMutation < BaseMutation
      graphql_name 'SignIn'

      argument :email, String, required: true
      argument :password, String, required: true

      field :access_token, String
      field :user, Types::Object::UserType

      def resolve(args)
        user = User.find_by(email: args[:email])
        raise GraphQL::ExecutionError, I18n.t('errors.graphql.sign_in_failed') unless user.present? && user.valid_password?(args[:password])
        raise GraphQL::ExecutionError, I18n.t('errors.graphql.not_verified') unless user.confirmed?

        user.update!(authentication_token: SecureRandom.hex)
        access_token = JsonWebToken.encode(id: user.id, authentication_token: user.authentication_token)
        context[:current_user] = user

        { user: , access_token: }
      end
    end
  end
end
