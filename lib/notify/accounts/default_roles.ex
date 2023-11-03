defmodule Notify.Accounts.DefaultRoles do
  def all() do
    [
      %{
        name: "User",
        permissions: %{
          "default" => ["add_contact", "send_contact_email", "view_email_history", "delete_email"],
        }
      },
      %{
        name: "Admin",
        permissions: %{
          "admin" => ["view_users", "view_user_emails", "delete_user"],
          "default" => ["add_contact", "send_contact_email", "view_email_history", "delete_email"],
          "gold_privilage" => ["add_groups", "add_group_contact", "send_group_email", "email_stats"]
        }
      },
    ]
  end
end
