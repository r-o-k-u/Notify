defmodule Notify.ContactsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Notify.Contacts` context.
  """

  @doc """
  Generate a contact.
  """
  def contact_fixture(attrs \\ %{}) do
    {:ok, contact} =
      attrs
      |> Enum.into(%{
        active: true,
        email: "some email",
        name: "some name",
        phone: "some phone"
      })
      |> Notify.Contacts.create_contact()

    contact
  end
end
