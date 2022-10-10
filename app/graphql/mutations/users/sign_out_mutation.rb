module Mutations
  module Users
    class SignOutMutation < BaseMutation
      graphql_name 'SignOut'

      field :user, Types::Object::UserType

      def resolve
        authorize_user!

        current_user.update!(authentication_token: nil)

        { user: current_user }
      end
    end
  end
end
