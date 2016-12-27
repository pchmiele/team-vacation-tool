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

  def call(conn, _) do
    IO.inspect conn

    case Guardian.Plug.current_resource(conn) do
      nil -> conn
      user ->
        put_private(conn, :absinthe, %{context: %{current_user: user}})
    end
  end
end
