module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    def current_user
      context[:current_user]
    end

    def authorize_user!
      raise GraphQL::ExecutionError, I18n.t('errors.graphql.authorize_failed') unless current_user
    end
  end
end
