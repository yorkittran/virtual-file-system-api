module Graph
  module Commands
    class BaseService
      attr_accessor :result, :error
  
      def initialize(user: , command: , current_folder:)
        @user = user
        @command = command
        @current_folder = current_folder
        @result = ''
        @error = ''
      end
  
    private
  
      attr_reader :user, :command, :current_folder
  
      def targeted_folder(folder_names)
        folder = current_folder
        folder_names&.each do |folder_name|
          folder = if folder_name.empty?
                     user.root_folder
                   else
                     folder.children.find_by!(name: folder_name)
                   end
        end
        folder
      end

      def targeted_item(path)
        folder_names = path.split('/')
        targeted_name = folder_names.pop
  
        folder = current_folder
        folder_names.each do |folder_name|
          folder = if folder_name.empty?
                     user.root_folder
                   else
                     folder.children.find_by!(name: folder_name)
                   end
        end
        folder.system_files.find_by(name: targeted_name) || folder.children.find_by(name: targeted_name)
      end
    end
  end
end
