
defmodule TeamVacationTool.UserTest do
  use TeamVacationTool.ModelCase

  alias TeamVacationTool.User

  @valid_attrs %{email: "bar@baz.com", password: "s3cr3t", role_id: 1}

  test "signup_changeset with valid attributes" do
    changeset = User.signup_changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "signup_changeset, email too short " do
    changeset = User.signup_changeset(
      %User{}, Map.put(@valid_attrs, :email, "")
    )
    refute changeset.valid?
  end

  test "signup_changeset, email invalid format" do
    changeset = User.signup_changeset(
      %User{}, Map.put(@valid_attrs, :email, "foo.com")
    )
    refute changeset.valid?
  end

  test "signup_changeset, password ok" do
    changeset = User.signup_changeset(%User{}, @valid_attrs)
    assert changeset.changes.password
    assert changeset.valid?
  end

  test "signup_changeset, password too short" do
    changeset = User.signup_changeset(
      %User{}, Map.put(@valid_attrs, :password, "12345")
    )
    refute changeset.valid?
  end
end
