defmodule Notify.EmailsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Notify.Emails` context.
  """

  @doc """
  Generate a email.
  """
  def email_fixture(attrs \\ %{}) do
    {:ok, email} =
      attrs
      |> Enum.into(%{
        active: true,
        content: "some content",
        title: "some title"
      })
      |> Notify.Emails.create_email()

    email
  end

  @doc """
  Generate a email.
  """
  def email_fixture(attrs \\ %{}) do
    {:ok, email} =
      attrs
      |> Enum.into(%{
        content: "some content",
        last_retry: ~T[14:00:00],
        retry_count: 42,
        status: :unsent,
        subject: "some subject"
      })
      |> Notify.Emails.create_email()

    email
  end
end
