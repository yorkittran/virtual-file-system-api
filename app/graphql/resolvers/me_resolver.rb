module Resolvers
  class MeResolver < BaseResolver
    type Types::Object::UserType, null: false

    def resolve
      authorize_user!

      context[:current_user]
    end
  end
end
