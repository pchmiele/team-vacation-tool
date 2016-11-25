defmodule TeamVacationTool.GraphQL.Resolvers.TeamResolver do
  alias TeamVacationTool.Team
  alias TeamVacationTool.Repo

  def all(_parent, _args, _info) do
    {:ok, Repo.all(Team) |> Repo.preload(:users) }
  end

  def find(_parent, %{id: id}, _info) do
    case Repo.get(Team, id) do
      nil  -> {:error, "Team id #{id} not found"}
      team -> {:ok, team }
    end
  end

end