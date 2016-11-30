defmodule TeamVacationTool.GraphQL.Context do
  @moduledoc """
  This module is just a regular plug that can look at the conn struct and build
  the appropriate absinthe context.
  """

  @behaviour Plug

  import Plug.Conn
  import Ecto.Query

  alias TeamVacationTool.{Repo, Session, User}

  def init(options), do: options

  def call(conn, _opts) do
    case build_context(conn) do
      {:ok, context} -> 
        put_private(conn, :absinthe, %{context: context})
      {:error, reason} ->
          conn
          |> send_resp(403, reason)
          |> halt()
        _ ->
          conn
          |> send_resp(400, "Bad Request")
          |> halt()
      end
  end

  defp build_context(conn) do
    with auth_header = get_req_header(conn, "authorization"),
         _ <- IO.puts(auth_header),
         {:ok, token}   <- parse_token(auth_header),
         {:ok, session} <- find_session_by_token(token),
    do:  find_user_by_session(session)
  end

  defp parse_token(["Token token=" <> token]) do
    {:ok, String.replace(token, "\"", "")}
  end
  defp parse_token(_non_token_header), do: :error

  defp find_session_by_token(token) do
    case Repo.one(from s in Session, where: s.token == ^token) do
      nil     -> :error
      session -> {:ok, session}
    end
  end

  defp find_user_by_session(session) do
    case Repo.get(User, session.user_id) do
      nil  -> :error
      current_user -> {:ok, %{current_user: current_user}}
    end
  end
end
