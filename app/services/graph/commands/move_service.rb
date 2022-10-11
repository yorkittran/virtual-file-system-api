module Graph
  module Commands
    class MoveService < BaseService
      def initialize(user: , command: , current_folder:)
        super
      end
  
      def call
        moved_path = command.split(' ').first
        destination_path = command.split(' ').second

        moved_item = targeted_item(moved_path)
        destination_folder = targeted_folder(destination_path.split('/'))

        if moved_item.is_a?(Folder)
          moved_item.update!(parent: destination_folder)
        else
          moved_item.update!(folder: destination_folder)
        end
      rescue ActiveRecord::RecordNotFound
        @error = 'Path is not found'
      rescue ActiveRecord::RecordInvalid
        @error = 'Cannot move a folder to become a subfolder of itself'
      end
    end
  end
end
