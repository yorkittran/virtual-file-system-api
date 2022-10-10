module Graph
  class Commands::ListService
    attr_accessor :result, :error

    def initialize(command)
      @path = command.split(' ').last
      @result = ''
      @error = ''
    end

    def call
      targeted_folder.children.each do |child_folder|
        @result += "#{child_folder.name} | #{child_folder.created_at.to_s} | #{child_folder.size}\n"
      end
      
      targeted_folder.system_files.each do |child_file|
        @result += "#{child_file.name} | #{child_file.created_at.to_s} | #{child_file.size}\n"
      end
    rescue ActiveRecord::RecordNotFound
      @error = 'File is not found'
    end

  private

    attr_reader :path, :data, :targeted_name

    def targeted_folder
      @targeted_folder ||= begin
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
end
