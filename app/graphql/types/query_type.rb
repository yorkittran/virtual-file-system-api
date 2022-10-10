module Types
  class QueryType < BaseObject
    field :me, resolver: Resolvers::MeResolver
    field :home, resolver: Resolvers::HomeResolver
    field :items, resolver: Resolvers::ItemsResolver
  end
end
