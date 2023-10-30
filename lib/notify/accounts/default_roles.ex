defmodule Notify.Accounts.DefaultRoles do
  def all() do
    [
      %{
        name: "User",
        permissions: %{
          "emails" => ["create", "read", "update", "delete"]
        }
      },
      %{
        name: "Admin",
        permissions: %{
          "emails" => ["create", "read", "update", "delete"],
          "contacts" => ["create","read", "update", "delete"],
          "groups" => ["create","read", "update", "delete"],
        }
      },
      %{
        name: "Guest",
        permissions: %{
          "emails" => ["read"]
        }
      }
    ]
  end
end
