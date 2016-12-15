defmodule TeamVacationTool.GraphQL.Resolvers.TeamResolver do
  alias TeamVacationTool.Team
  alias TeamVacationTool.Repo

  def all(_parent, _args, _info) do
    {:ok, Repo.all(Team) |> Repo.preload(:users) }
  end

  def current_team(_parent, %{context: %{current_user: current_user}}) do
    with user = current_user |> Repo.preload(:team) do
    {:ok, Repo.get(Team, user.team.id) |> Repo.preload(:users) }
    end
  end

  def find(_parent, %{id: id}, _info) do
    case Repo.get(Team, id) do
      nil  -> {:error, "Team id #{id} not found"}
      team -> {:ok, team }
    end
  end

end