defmodule TeamVacationTool.Schema do
  use Absinthe.Schema
  alias TeamVacationTool.Resolvers

  import_types TeamVacationTool.Schema.Types

  query do
    field :teams, list_of(:team) do
      resolve &Resolvers.TeamResolver.all/3
    end
    field :user, :user do
      arg :id, non_null(:id)

      resolve &Resolvers.UserResolver.find/3
    end
    field :users, list_of(:user) do
      resolve &Resolvers.UserResolver.all/3
    end
  end

end