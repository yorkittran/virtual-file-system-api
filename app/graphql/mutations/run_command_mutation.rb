module Mutations
  class RunCommandMutation < BaseMutation
    graphql_name 'RunCommand'

    argument :command, String, required: true
    argument :folder_id, String, required: true

    field :result, String
    field :error, String
    field :current_folder_id, ID

    def resolve(args)
      authorize_user!

      command_head = args[:command].split(' ', 2).first
      command = args[:command].split(' ', 2).second
      current_folder = Folder.by_user(current_user).find(args[:folder_id])
      params = { user: current_user, command: command, current_folder: current_folder }
      @error = ''

      service = case command_head
                when 'cd'
                  Graph::Commands::ChangeDirService.new(**params)
                when 'cr'
                  Graph::Commands::CreateService.new(**params) if validate(command)
                when 'cat'
                  Graph::Commands::ConcatenateService.new(**params) if validate(command)
                when 'ls'
                  Graph::Commands::ListService.new(**params)
                when 'mv'
                  Graph::Commands::MoveService.new(**params) if validate(command)
                when 'rm'
                  Graph::Commands::RemoveService.new(**params) if validate(command)
                else
                  @error = "Command not found: #{command_head}"
                end
      return { result: '', error: @error, current_folder_id: current_folder.id } if @error.present?

      service.call

      { result: service.result, error: service.error, current_folder_id: service.current_folder.id }
    end

    def validate(command)
      return @error = 'Missing param: Path' unless command.present?

      true
    end
  end
end
