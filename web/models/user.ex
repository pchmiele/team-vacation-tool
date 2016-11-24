defmodule TeamVacationTool.User do
  use TeamVacationTool.Web, :model
  
  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true

    belongs_to :team, Team
    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(email), [])
    |> validate_length(:email, min: 1, max: 255)
    |> validate_format(:email, ~r/@/)
  end

  def registration_changeset(model, params \\ :empty) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6)
    |> put_encrypted_password
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