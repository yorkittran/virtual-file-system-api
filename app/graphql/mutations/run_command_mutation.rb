module Mutations
  class RunCommandMutation < BaseMutation
    graphql_name 'RunCommand'

    argument :command, String, required: true

    field :result, String
    field :error, String

    def resolve(args)
      authorize_user!

      command_head = args[:command].split(' ').first
      service = case command_head
                when 'cr'
                  Graph::Commands::CreateService.new(args[:command])
                when 'cat'
                  Graph::Commands::ConcatenateService.new(args[:command])
                when 'ls'
                  Graph::Commands::ListService.new(args[:command])
                when 'mv'
                  Graph::Commands::MoveService.new(args[:command])
                when 'rm'
                  Graph::Commands::RemoveService.new(args[:command])
                end
      service.call

      { result: service.result, error: service.error }
    end
  end
end
