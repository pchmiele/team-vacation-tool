defmodule TeamVacationTool.UserController do
  use TeamVacationTool.Web, :controller

  alias TeamVacationTool.User

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => user_params}) do
    changeset = User.signup_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TeamVacationTool.ErrorView, "error.json", changeset: changeset)
    end
  end

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.json", users: users)
  end
end
