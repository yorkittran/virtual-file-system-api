module Graph
  module Commands
    class ChangeDirService < BaseService
      def initialize(user: , command: , current_folder:)
        super
      end
  
      def call
        folder_names = command&.split('/')

        if folder_names.present?
          @current_folder = targeted_folder(folder_names)
        else
          @current_folder = user.root_folder
        end

        @result = current_folder.path
      rescue ActiveRecord::RecordNotFound
        @error = 'Path is not found'
      end
    end
  end
end
