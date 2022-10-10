module Graph
  module Commands
    class ConcatenateService < BaseService
      def initialize(user: , command: , current_folder:)
        super
      end
  
      def call
        folder_names = command.split('/')
        targeted_name = folder_names.pop 
  
        system_file = targeted_folder(folder_names).system_files.find_by!(name: targeted_name)
        @result = system_file.data
      rescue ActiveRecord::RecordNotFound
        @error = 'File is not found'
      end
    end
  end
end
