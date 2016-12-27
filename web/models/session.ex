defmodule TeamVacationTool.Session do
  alias TeamVacationTool.User

  def authenticate(user, credentials) do
    case check_password(user, credentials.password) do
      true -> {:ok, user}
      _ -> {:error, "Incorrect login credentials"}
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> false
      _ -> Comeonin.Bcrypt.checkpw(password, user.encrypted_password)
    end
  end
end
