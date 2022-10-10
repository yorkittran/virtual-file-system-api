class VirtualFileSystemApiSchema < GraphQL::Schema
  mutation Types::MutationType
  query Types::QueryType

  # For batch-loading (see https://graphql-ruby.org/dataloader/overview.html)
  use GraphQL::Dataloader

  rescue_from ActiveRecord::RecordInvalid do |err, _obj, _args, _ctx, _field|
    raise GraphQL::ExecutionError, err
  end
end
