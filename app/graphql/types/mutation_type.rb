module Types
  class MutationType < Types::BaseObject
    field :run_command, mutation: Mutations::RunCommandMutation
    # field :sign_in, mutation: Mutations::Users::SignInMutation
    # field :sign_out, mutation: Mutations::Users::SignOutMutation
  end
end
