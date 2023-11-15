# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Notify.Repo.insert!(%Notify.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


# alias Notify.Repo
# alias Notify.Accounts.Role
# roles = ~w(User Administrator  Guest)

# Enum.each(roles, fn name ->
#   Notify.Accounts.create_role(%{name: name })
# end)


for role <- Notify.Accounts.DefaultRoles.all() do
  unless Notify.Accounts.get_role_by_name(role.name) do
    {:ok, _role} = Notify.Accounts.create_role(role)
  end
end


for user <- Notify.Accounts.DefaultUser.all() do
  case Notify.Accounts.get_role_by_name(user.role_name) do
    %Notify.Accounts.Role{} = role ->
      IO.puts("User already has a role: #{role.name}")
      case Notify.Accounts.register_user(user ,role) do
        {:ok, _registered_user} ->
          IO.puts("User with default role registered.")
        {:error, changeset} ->
          IO.puts("Error registering user: #{inspect(changeset)}")
      end
    nil ->
      IO.puts("Role not found")
  end
end
