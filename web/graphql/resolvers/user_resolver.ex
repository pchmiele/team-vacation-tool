defmodule TeamVacationTool.GraphQL.Resolvers.UserResolver do
  alias TeamVacationTool.User
  alias TeamVacationTool.Repo

  def find(_parent, %{id: id}, _info) do
    case Repo.get(User, id) do
      nil  -> {:error, "User id #{id} not found"}
      user -> {:ok, user}
    end
  end

  def profile(_parent,  %{context: %{current_user: current_user}}) do
    {:ok, current_user |> Repo.preload(:team) }
  end

  def all(_parent, _args, _info) do
    {:ok, Repo.all(User) |> Repo.preload(:team) }
  end
  
end