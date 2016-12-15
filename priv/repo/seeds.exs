alias TeamVacationTool.{Repo, User, Team, Role}

admin_changeset = Role.changeset(%Role{}, %{name: "user", admin: :false})
admin_role = Repo.insert!(admin_changeset)
user_changeset = Role.changeset(%Role{}, %{name: "admin", admin: :true})
user_role = Repo.insert!(user_changeset)

intel_changeset = Team.changeset(%Team{}, %{name: "Intel"})
team_intel = Repo.insert!(intel_changeset)
scalac_changeset = Team.changeset(%Team{}, %{name: "Scalac"})
team_scalac = Repo.insert!(scalac_changeset)

user1_intel_changeset = User.with_team_changeset(%User{},%{email: "user1@intel.com", password: "password", team_id: team_intel.id, role_id: user_role.id})
user2_intel_changeset = User.with_team_changeset(%User{},%{email: "user2@intel.com", password: "password", team_id: team_intel.id, role_id: user_role.id})
admin_intel_changeset = User.with_team_changeset(%User{},%{email: "admin@intel.com", password: "password", team_id: team_intel.id, role_id: admin_role.id})
Repo.insert!(user1_intel_changeset)
Repo.insert!(user2_intel_changeset)
Repo.insert!(admin_intel_changeset)

user1_scalac_changeset = User.with_team_changeset(%User{},%{email: "user1@scalac.com", password: "password", team_id: team_scalac.id, role_id: user_role.id})
user2_scalac_changeset = User.with_team_changeset(%User{},%{email: "user2@scalac.com", password: "password", team_id: team_scalac.id, role_id: user_role.id})
admin_scalac_changeset = User.with_team_changeset(%User{},%{email: "admin@scalac.com", password: "password", team_id: team_scalac.id, role_id: admin_role.id})
Repo.insert!(user1_scalac_changeset)
Repo.insert!(user2_scalac_changeset)
Repo.insert!(admin_scalac_changeset)
