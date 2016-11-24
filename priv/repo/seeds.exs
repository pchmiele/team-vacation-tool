# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TeamVacationTool.Repo.insert!(%TeamVacationTool.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias TeamVacationTool.Repo
alias TeamVacationTool.User
alias TeamVacationTool.Team

intel_changeset = Team.changeset(%Team{}, %{name: "Intel"})
team_intel = Repo.insert!(intel_changeset)
scalac_changeset = Team.changeset(%Team{}, %{name: "Scalac"})
team_scalac = Repo.insert!(scalac_changeset)

user1_changeset = User.with_team_changeset(%User{},%{email: "user@user.com", password: "password", team_id: team_intel.id})
user1 =  Repo.insert!(user1_changeset)

user2_changeset = User.with_team_changeset(%User{},%{email: "admin@admin.com", password: "password", team_id: team_scalac.id})
user2 =  Repo.insert!(user2_changeset)