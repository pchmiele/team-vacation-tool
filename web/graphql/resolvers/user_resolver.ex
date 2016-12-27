defmodule TeamVacationTool.GraphQL.Resolvers.UserResolver do
  alias TeamVacationTool.User
  alias TeamVacationTool.Repo
  alias TeamVacationTool.Session

  def find(_parent, %{id: id}, _info) do
    case Repo.get(User, id) do
      nil  -> {:error, "User id #{id} not found"}
      user -> {:ok, user}
    end
  end

  def profile(_parent,  %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end

  def all(_parent, _args, _info) do
    {:ok, Repo.all(User)}
  end

  def sign_in(credentials, _info) do
    case try_sign_in(credentials) do
      {:ok, response} -> {:ok, response}
      _ -> {:error, "Could not sign in using given credentials"}
    end
  end

  defp try_sign_in(credentials) do
    with user <- Repo.get_by(User, email: credentials.email),
         {:ok, authenticated_user} <- Session.authenticate(user, credentials),
         {:ok, jwt, _} <- Guardian.encode_and_sign(authenticated_user, :access) do
      {:ok, %{token: jwt}}
    end
  end

  def sign_up(params, _info) do
    changeset = User.signup_changeset(%User{}, params)

    case Repo.insert(changeset) do
      {:ok, user} -> {:ok, user}
      {:error, changeset} -> {:error, "Could not sign_up"}
    end
  end

end
