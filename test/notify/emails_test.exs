defmodule Notify.EmailsTest do
  use Notify.DataCase

  alias Notify.Emails

  describe "email" do
    alias Notify.Emails.Email

    import Notify.EmailsFixtures

    @invalid_attrs %{active: nil, title: nil, content: nil}

    test "list_email/0 returns all email" do
      email = email_fixture()
      assert Emails.list_email() == [email]
    end

    test "get_email!/1 returns the email with given id" do
      email = email_fixture()
      assert Emails.get_email!(email.id) == email
    end

    test "create_email/1 with valid data creates a email" do
      valid_attrs = %{active: true, title: "some title", content: "some content"}

      assert {:ok, %Email{} = email} = Emails.create_email(valid_attrs)
      assert email.active == true
      assert email.title == "some title"
      assert email.content == "some content"
    end

    test "create_email/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Emails.create_email(@invalid_attrs)
    end

    test "update_email/2 with valid data updates the email" do
      email = email_fixture()
      update_attrs = %{active: false, title: "some updated title", content: "some updated content"}

      assert {:ok, %Email{} = email} = Emails.update_email(email, update_attrs)
      assert email.active == false
      assert email.title == "some updated title"
      assert email.content == "some updated content"
    end

    test "update_email/2 with invalid data returns error changeset" do
      email = email_fixture()
      assert {:error, %Ecto.Changeset{}} = Emails.update_email(email, @invalid_attrs)
      assert email == Emails.get_email!(email.id)
    end

    test "delete_email/1 deletes the email" do
      email = email_fixture()
      assert {:ok, %Email{}} = Emails.delete_email(email)
      assert_raise Ecto.NoResultsError, fn -> Emails.get_email!(email.id) end
    end

    test "change_email/1 returns a email changeset" do
      email = email_fixture()
      assert %Ecto.Changeset{} = Emails.change_email(email)
    end
  end

  describe "emails" do
    alias Notify.Emails.Email

    import Notify.EmailsFixtures

    @invalid_attrs %{status: nil, subject: nil, content: nil, retry_count: nil, last_retry: nil}

    test "list_emails/0 returns all emails" do
      email = email_fixture()
      assert Emails.list_emails() == [email]
    end

    test "get_email!/1 returns the email with given id" do
      email = email_fixture()
      assert Emails.get_email!(email.id) == email
    end

    test "create_email/1 with valid data creates a email" do
      valid_attrs = %{status: :unsent, subject: "some subject", content: "some content", retry_count: 42, last_retry: ~T[14:00:00]}

      assert {:ok, %Email{} = email} = Emails.create_email(valid_attrs)
      assert email.status == :unsent
      assert email.subject == "some subject"
      assert email.content == "some content"
      assert email.retry_count == 42
      assert email.last_retry == ~T[14:00:00]
    end

    test "create_email/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Emails.create_email(@invalid_attrs)
    end

    test "update_email/2 with valid data updates the email" do
      email = email_fixture()
      update_attrs = %{status: :sent, subject: "some updated subject", content: "some updated content", retry_count: 43, last_retry: ~T[15:01:01]}

      assert {:ok, %Email{} = email} = Emails.update_email(email, update_attrs)
      assert email.status == :sent
      assert email.subject == "some updated subject"
      assert email.content == "some updated content"
      assert email.retry_count == 43
      assert email.last_retry == ~T[15:01:01]
    end

    test "update_email/2 with invalid data returns error changeset" do
      email = email_fixture()
      assert {:error, %Ecto.Changeset{}} = Emails.update_email(email, @invalid_attrs)
      assert email == Emails.get_email!(email.id)
    end

    test "delete_email/1 deletes the email" do
      email = email_fixture()
      assert {:ok, %Email{}} = Emails.delete_email(email)
      assert_raise Ecto.NoResultsError, fn -> Emails.get_email!(email.id) end
    end

    test "change_email/1 returns a email changeset" do
      email = email_fixture()
      assert %Ecto.Changeset{} = Emails.change_email(email)
    end
  end
end
