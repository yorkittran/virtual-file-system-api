module Resolvers
  class HomeResolver < BaseResolver
    type Types::Object::FolderType, null: false

    def resolve
      Folder.first
    end
  end
end
