module Graph
  module Commands
    class ListService < BaseService
      def initialize(user: , command: , current_folder:)
        super
      end
  
      def call
        folder_names = command&.split('/')
  
        targeted_folder(folder_names).children.each do |child_folder|
          @result += "#{child_folder.name} | #{child_folder.created_at.to_s} | #{child_folder.size}\n"
        end
        
        targeted_folder(folder_names).system_files.each do |child_file|
          @result += "#{child_file.name} | #{child_file.created_at.to_s} | #{child_file.size}\n"
        end
      rescue ActiveRecord::RecordNotFound
        @error = 'File is not found'
      end
    end
  end
end
