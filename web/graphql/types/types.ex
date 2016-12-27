defmodule TeamVacationTool.GraphQL.Types.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: TeamVacationTool.Repo

  object :user do
    field :id, :id
    field :email, :string
    field :team, :team, resolve: assoc(:team)
    field :role_id, :integer
  end

  object :team do
    field :id, :id
    field :name, :string
    field :users, list_of(:user), resolve: assoc(:users)
  end

  object :session do
    field :token, :string
  end

end
