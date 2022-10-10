module Graph
  class Commands::CreateService
    attr_accessor :result, :error

    def initialize(command)
      @path = command.split(' ').second
      @data = command.split(' ').third
      @result = ''
      @error = ''
    end

    def call
      if data
        targeted_folder.system_files.create!(name: targeted_name, data: data)
      else
        targeted_folder.children.create!(name: targeted_name)
      end
    rescue ActiveRecord::RecordNotFound
      @error = 'File is not found'
    rescue ActiveRecord::RecordInvalid
      @error = 'Path is exist'
    end

  private

    attr_reader :path, :data, :targeted_name

    def targeted_folder
      @targeted_folder ||= begin
        folder_names = path.split('/')
        @targeted_name = folder_names.pop

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
end
