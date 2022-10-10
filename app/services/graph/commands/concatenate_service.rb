module Graph
  class Commands::ConcatenateService
    attr_accessor :result, :error

    def initialize(command)
      @path = command.split(' ').last
      @result = ''
      @error = ''
    end

    def call
      system_file = targeted_folder.system_files.find_by!(name: targeted_name)
      @result = system_file.data
    rescue ActiveRecord::RecordNotFound
      @error = 'File is not found'
    end

  private

    attr_reader :path, :targeted_name

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
