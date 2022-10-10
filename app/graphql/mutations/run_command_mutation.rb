module Mutations
  class RunCommandMutation < BaseMutation
    graphql_name 'RunCommand'

    argument :command, String, required: true
    argument :folder_id, String, required: true

    field :result, String
    field :error, String

    def resolve(args)
      authorize_user!

      command_head = args[:command].split(' ', 2).first
      command = args[:command].split(' ', 2).second
      current_folder = Folder.by_user(current_user).find(args[:folder_id])
      params = { user: current_user, command: command, current_folder: current_folder }

      service = case command_head
                when 'cd'
                  Graph::Commands::ChangeDirService.new(**params)
                when 'cr'
                  Graph::Commands::CreateService.new(**params)
                when 'cat'
                  Graph::Commands::ConcatenateService.new(**params)
                when 'ls'
                  Graph::Commands::ListService.new(**params)
                when 'mv'
                  Graph::Commands::MoveService.new(**params)
                when 'rm'
                  Graph::Commands::RemoveService.new(**params)
                end
      service.call

      { result: service.result, error: service.error }
    end
  end
end
