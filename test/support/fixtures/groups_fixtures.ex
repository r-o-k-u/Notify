defmodule Notify.GroupsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Notify.Groups` context.
  """

  @doc """
  Generate a group.
  """
  def group_fixture(attrs \\ %{}) do
    {:ok, group} =
      attrs
      |> Enum.into(%{
        active: true,
        name: "some name"
      })
      |> Notify.Groups.create_group()

    group
  end
end
