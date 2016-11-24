defmodule TeamVacationTool.Team do
  use TeamVacationTool.Web, :model

  alias TeamVacationTool.User
  schema "teams" do
    field :name, :string

    has_many :users, User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
