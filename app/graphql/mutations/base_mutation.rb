module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    def current_user
      context[:current_user]
    end

    def authorize_user!
      raise GraphQL::ExecutionError, You must login to perform this action! unless current_user
    end
  end
end
