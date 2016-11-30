defmodule TeamVacationTool.User do
  use TeamVacationTool.Web, :model
  
  alias TeamVacationTool.Team

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true
    field :role_id, :integer

    belongs_to :team, Team
    timestamps
  end

  @required_fields ~w(email password)a
  @optional_fields ~w(role_id)a

  def registration_changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:email, min: 1, max: 255)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> put_encrypted_password
  end

  def with_team_changeset(model, params \\ :empty) do
    model
    |> registration_changeset(params)
    |> cast(params, ~w(team_id), [])
  end

  defp put_encrypted_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end