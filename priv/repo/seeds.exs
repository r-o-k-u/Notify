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

alias Notify.Repo
alias Notify.Accounts.Role

alias Notify.Accounts.Permission
roles = ~w(User Administrator  Guest)
permissions = ~w(create_email create_group  super_user)

Enum.each(permissions, fn name ->
  Repo.insert!(%Notify.Accounts.Permission{name: name })
end)
Enum.each(roles, fn name ->
  Notify.Accounts.create_role(%{name: name })
end)
