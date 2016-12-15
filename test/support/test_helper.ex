defmodule TeamVacationTool.TestHelper do
  alias TeamVacationTool.Repo
  alias TeamVacationTool.User
  alias TeamVacationTool.Role
  alias TeamVacationTool.Session
  alias TeamVacationTool.Team

  import Ecto, only: [build_assoc: 2]
  
  # def create_role(%{name: name, admin: admin}) do
  #   Role.changeset(%Role{}, %{name: name, admin: admin})
  #   |> Repo.insert
  # end

  # def create_user(role, %{email: email, password: password}) do
  #   role
  #   |> build_assoc(:users)
  #   |> User.changeset(%{email: email, password: password})
  #   |> Repo.insert
  # end
  
  # def create_user(role, team, %{email: email, password: password}) do
  #   role
  #   |> build_assoc(:users)
  #   |> User.changeset(%{email: email, password: password, team_id: team.id})
  #   |> Repo.insert
  # end

  # def create_team(%{name: title}) do
  #   Team.changeset(%Team{}, %{name: name})
  #   |> Repo.insert
  # end

  # def create_session(user, %{name: title}) do
  #   user
  #   |> build_assoc(:teams)
  #   |> Team.changeset(%{name: name})
  #   |> Repo.insert
  # end
end