defmodule TeamVacationTool.Role do
  use TeamVacationTool.Web, :model

  schema "roles" do
    field :name, :string
    field :admin, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :admin])
    |> validate_required([:name, :admin])
  end
end
