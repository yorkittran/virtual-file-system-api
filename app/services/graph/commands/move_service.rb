module Graph
  class Commands::MoveService
    attr_accessor :result, :error

    def initialize(command)
      @targeted_path = command.split(' ').second
      @destination_path = command.split(' ').third
      @result = ''
      @error = ''
    end

    def call
      targeted_folder = folder(targeted_path)
      destination_folder = folder(destination_path)
      targeted_folder.update!(parent: destination_folder)
    rescue ActiveRecord::RecordNotFound
      @error = 'Path is not found'
    rescue ActiveRecord::RecordInvalid
      @error = 'Cannot move a folder to become a subfolder of itself'
    end

  private

    attr_reader :targeted_path, :destination_path

    def folder(path)
      folder_names = path.split('/')

      current_folder = Folder.root
      folder_names.each do |folder_name|
        current_folder = if folder_name.empty?
                          Folder.root
                        else
                          current_folder.children.find_by!(name: folder_name)
                        end
      end
      current_folder
    end
  end
end
