module Graph
  module Commands
    class ChangeDirService < BaseService
      def initialize(user: , command: , current_folder:)
        super
      end
  
      def call
        folder_names = command&.split('/')
  
        @result = targeted_folder(folder_names).id
      rescue ActiveRecord::RecordNotFound
        @error = 'Path is not found'
      end
    end
  end
end
