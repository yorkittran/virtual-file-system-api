module Graph
  module Commands
    class MoveService < BaseService
      def initialize(user: , command: , current_folder:)
        super
      end
  
      def call
        moved_path = command.split(' ').first
        destination_path = command.split(' ').second

        moved_folder = targeted_folder(moved_path.split('/'))
        destination_folder = targeted_folder(destination_path.split('/'))

        moved_folder.update!(parent: destination_folder)
      rescue ActiveRecord::RecordNotFound
        @error = 'Path is not found'
      rescue ActiveRecord::RecordInvalid
        @error = 'Cannot move a folder to become a subfolder of itself'
      end
    end
  end
end
