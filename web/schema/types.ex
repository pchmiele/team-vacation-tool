defmodule TeamVacationTool.Schema.Types do
  use Absinthe.Schema.Notation

  object :user do
    field :id, :id
    field :email, :string
    field :teams, :team
  end

  object :team do
    field :id, :id
    field :name, :string
    field :users, list_of(:user)
  end

end