module Types
  class QueryType < BaseObject
    field :home, resolver: Resolvers::HomeResolver
  end
end
