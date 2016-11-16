
defmodule TeamVacationTool.UserTest do
  use TeamVacationTool.ModelCase

  alias TeamVacationTool.User

  @valid_attrs %{email: "bar@baz.com", password: "s3cr3t"}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset, email too short " do
    changeset = User.changeset(
      %User{}, Map.put(@valid_attrs, :email, "")
    )
    refute changeset.valid?
  end

  test "changeset, email invalid format" do
    changeset = User.changeset(
      %User{}, Map.put(@valid_attrs, :email, "foo.com")
    )
    refute changeset.valid?
  end

  test "registration_changeset, password ok" do
    changeset = User.registration_changeset(%User{}, @valid_attrs)
    assert changeset.changes.encrypted_password
    assert changeset.valid?
  end

  test "registration_changeset, password too short" do
    changeset = User.registration_changeset(
      %User{}, Map.put(@valid_attrs, :password, "12345")
    )
    refute changeset.valid?
  end
end