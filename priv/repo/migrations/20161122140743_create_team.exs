defmodule TeamVacationTool.Repo.Migrations.CreateTeam do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string

      timestamps()
    end

    create unique_index(:teams, [:name])

    alter table(:users) do
      add :team_id, references(:teams, on_delete: :nothing)
    end
  end
end
