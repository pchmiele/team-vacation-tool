defmodule TeamVacationTool.TeamView do
  use TeamVacationTool.Web, :view

  def render("index.json", %{teams: teams}) do
    %{data: render_many(teams, TeamVacationTool.TeamView, "team.json")}
  end

  def render("show.json", %{team: team}) do
    %{data: render_one(team, TeamVacationTool.TeamView, "team.json")}
  end

  def render("team.json", %{team: team}) do
    %{id: team.id,
      name: team.name}
  end
end
