defmodule Notify.Accounts.Permission do
  use Ecto.Schema
  import Ecto.Changeset

  def all() do
    %{
      "admin" => ["view_users", "view_user_emails", "delete_user"],
      "superuser" => ["all","upgrade_user_plan","grant_admin", "revoke_admin"],
      "default" => ["add_contact", "send_contact_email", "view_email_history", "delete_email"],
      "gold_privilage" => ["add_groups", "add_group_contact", "send_group_email", "email_stats"],
    }
  end

  def validate_permissions(changeset, field) do
    validate_change(changeset, field, fn _field, permissions ->
      permissions
      |> Enum.reject(&has_permission?(all(), &1))
      |> case do
        [] -> []
        invalid_permissions -> [{field, {"invalid permissions", invalid_permissions}}]
      end
    end)
  end

  def has_permission?(permissions, {name, actions}) do
    exists?(name, permissions) && actions_valid?(name, actions, permissions)
  end

  defp exists?(name, permissions), do: Map.has_key?(permissions, name)

  defp actions_valid?(permission_name, given_action, permissions) when is_binary(given_action) do
    actions_valid?(permission_name, [given_action], permissions)
  end

  defp actions_valid?(permission_name, given_actions, permissions) when is_list(given_actions) do
    defined_actions = Map.get(permissions, permission_name)
    Enum.all?(given_actions, &(&1 in defined_actions))
  end
end
