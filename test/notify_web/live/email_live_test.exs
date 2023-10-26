defmodule NotifyWeb.EmailLiveTest do
  use NotifyWeb.ConnCase

  import Phoenix.LiveViewTest
  import Notify.EmailsFixtures

  @create_attrs %{status: :unsent, subject: "some subject", content: "some content", retry_count: 42, last_retry: "14:00"}
  @update_attrs %{status: :sent, subject: "some updated subject", content: "some updated content", retry_count: 43, last_retry: "15:01"}
  @invalid_attrs %{status: nil, subject: nil, content: nil, retry_count: nil, last_retry: nil}

  defp create_email(_) do
    email = email_fixture()
    %{email: email}
  end

  describe "Index" do
    setup [:create_email]

    test "lists all emails", %{conn: conn, email: email} do
      {:ok, _index_live, html} = live(conn, ~p"/emails")

      assert html =~ "Listing Emails"
      assert html =~ email.subject
    end

    test "saves new email", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/emails")

      assert index_live |> element("a", "New Email") |> render_click() =~
               "New Email"

      assert_patch(index_live, ~p"/emails/new")

      assert index_live
             |> form("#email-form", email: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#email-form", email: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/emails")

      html = render(index_live)
      assert html =~ "Email created successfully"
      assert html =~ "some subject"
    end

    test "updates email in listing", %{conn: conn, email: email} do
      {:ok, index_live, _html} = live(conn, ~p"/emails")

      assert index_live |> element("#emails-#{email.id} a", "Edit") |> render_click() =~
               "Edit Email"

      assert_patch(index_live, ~p"/emails/#{email}/edit")

      assert index_live
             |> form("#email-form", email: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#email-form", email: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/emails")

      html = render(index_live)
      assert html =~ "Email updated successfully"
      assert html =~ "some updated subject"
    end

    test "deletes email in listing", %{conn: conn, email: email} do
      {:ok, index_live, _html} = live(conn, ~p"/emails")

      assert index_live |> element("#emails-#{email.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#emails-#{email.id}")
    end
  end

  describe "Show" do
    setup [:create_email]

    test "displays email", %{conn: conn, email: email} do
      {:ok, _show_live, html} = live(conn, ~p"/emails/#{email}")

      assert html =~ "Show Email"
      assert html =~ email.subject
    end

    test "updates email within modal", %{conn: conn, email: email} do
      {:ok, show_live, _html} = live(conn, ~p"/emails/#{email}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Email"

      assert_patch(show_live, ~p"/emails/#{email}/show/edit")

      assert show_live
             |> form("#email-form", email: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#email-form", email: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/emails/#{email}")

      html = render(show_live)
      assert html =~ "Email updated successfully"
      assert html =~ "some updated subject"
    end
  end
end
