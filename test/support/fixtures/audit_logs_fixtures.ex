defmodule Notify.AuditLogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Notify.AuditLogs` context.
  """

  @doc """
  Generate a audit_log.
  """
  def audit_log_fixture(attrs \\ %{}) do
    {:ok, audit_log} =
      attrs
      |> Enum.into(%{
        action: "some action",
        active: true,
        description: "some description"
      })
      |> Notify.AuditLogs.create_audit_log()

    audit_log
  end
end
