defmodule Notify.Accounts.DefaultUser do
  def all() do
    [
      %{
        first_name: "Default",
        last_name: "User",
        email: "user@notify.com",
        msisdn: "254711223344",
        active: true,
        password: "password",
        custom_permissions: %{
          "default" => ["add_contact", "send_contact_email", "view_email_history", "delete_email"],
        },
        role_name: "User"
      },
      %{
        first_name: "Default",
        last_name: "Admin",
        email: "admin@notify.com",
        msisdn: "254711223355",
        active: true,
        password: "password",
        role_name: "Admin"
      }
    ]
  end
end
