module Graph
  class Commands::RemoveService
    attr_accessor :result, :error

    def initialize(command)
      @paths = command.split(' ')
      @paths.shift
      @result = ''
      @error = ''
    end

    def call
      paths.each do |path|
        item = targeted_item(path)
        if item.present?
          item.destroy 
        else
          raise ActiveRecord::RecordNotFound
        end
      end
    rescue ActiveRecord::RecordNotFound
      @error = 'Path is not found'
    end

  private

    attr_reader :paths, :data, :targeted_name

    def targeted_item(path)
      folder_names = path.split('/')
      targeted_name = folder_names.pop

      current_folder = Folder.root
      folder_names.each do |folder_name|
        current_folder = if folder_name.empty?
                          Folder.root
                        else
                          current_folder.children.find_by!(name: folder_name)
                        end
      end
      current_folder.system_files.find_by(name: targeted_name) || current_folder.children.find_by(name: targeted_name)
    end
  end
end
