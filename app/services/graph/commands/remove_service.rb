module Graph
  module Commands
    class RemoveService < BaseService
      def initialize(user: , command: , current_folder:)
        super
      end

      def call
        paths = command.split(' ')
        paths.each do |path|
          item = targeted_item(path)
          raise ActiveRecord::RecordNotFound unless item.present?

          item.destroy 
        end
      rescue ActiveRecord::RecordNotFound
        @error = 'Path is not found'
      end
    end
  end
end
