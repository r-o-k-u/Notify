defmodule Notify.AuditLogsTest do
  use Notify.DataCase

  alias Notify.AuditLogs

  describe "audit_log" do
    alias Notify.AuditLogs.AuditLog

    import Notify.AuditLogsFixtures

    @invalid_attrs %{active: nil, description: nil, action: nil}

    test "list_audit_log/0 returns all audit_log" do
      audit_log = audit_log_fixture()
      assert AuditLogs.list_audit_log() == [audit_log]
    end

    test "get_audit_log!/1 returns the audit_log with given id" do
      audit_log = audit_log_fixture()
      assert AuditLogs.get_audit_log!(audit_log.id) == audit_log
    end

    test "create_audit_log/1 with valid data creates a audit_log" do
      valid_attrs = %{active: true, description: "some description", action: "some action"}

      assert {:ok, %AuditLog{} = audit_log} = AuditLogs.create_audit_log(valid_attrs)
      assert audit_log.active == true
      assert audit_log.description == "some description"
      assert audit_log.action == "some action"
    end

    test "create_audit_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AuditLogs.create_audit_log(@invalid_attrs)
    end

    test "update_audit_log/2 with valid data updates the audit_log" do
      audit_log = audit_log_fixture()
      update_attrs = %{active: false, description: "some updated description", action: "some updated action"}

      assert {:ok, %AuditLog{} = audit_log} = AuditLogs.update_audit_log(audit_log, update_attrs)
      assert audit_log.active == false
      assert audit_log.description == "some updated description"
      assert audit_log.action == "some updated action"
    end

    test "update_audit_log/2 with invalid data returns error changeset" do
      audit_log = audit_log_fixture()
      assert {:error, %Ecto.Changeset{}} = AuditLogs.update_audit_log(audit_log, @invalid_attrs)
      assert audit_log == AuditLogs.get_audit_log!(audit_log.id)
    end

    test "delete_audit_log/1 deletes the audit_log" do
      audit_log = audit_log_fixture()
      assert {:ok, %AuditLog{}} = AuditLogs.delete_audit_log(audit_log)
      assert_raise Ecto.NoResultsError, fn -> AuditLogs.get_audit_log!(audit_log.id) end
    end

    test "change_audit_log/1 returns a audit_log changeset" do
      audit_log = audit_log_fixture()
      assert %Ecto.Changeset{} = AuditLogs.change_audit_log(audit_log)
    end
  end
end
