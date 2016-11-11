defmodule TeamVacationTool.PageController do
  use TeamVacationTool.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
