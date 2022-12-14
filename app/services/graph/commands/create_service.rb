module Graph
  module Commands
    class CreateService < BaseService
      def initialize(user: , command: , current_folder:)
        super
      end
      
      def call
        path = command.split(' ', 2).first
        data = command.split(' ', 2).second
        folder_names = path.split('/')
        targeted_name = folder_names.pop 

        if data
          targeted_folder(folder_names).system_files.create!(name: targeted_name, data: data)
        else
          targeted_folder(folder_names).children.create!(user: user, name: targeted_name)
        end
      rescue ActiveRecord::RecordNotFound
        @error = 'File is not found'
      rescue ActiveRecord::RecordInvalid => e
        @error = e.message
      end
    end
  end
end
