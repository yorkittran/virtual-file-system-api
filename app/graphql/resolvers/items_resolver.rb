module Resolvers
  class ItemsResolver < BaseResolver
    type Types::Object::ItemsType, null: false

    argument :folder_id, ID, required: true

    def resolve(args)
      authorize_user!

      current_user.folders.find(args[:folder_id])
    end
  end
end
