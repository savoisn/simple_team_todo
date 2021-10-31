defmodule SimpleTeamTodo.TodoFixtures do
  import SimpleTeamTodo.AccountsFixtures

  @moduledoc """
  This module defines test helpers for creating
  entities via the `SimpleTeamTodo.Todo` context.
  """

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    user = user_fixture()

    {:ok, project} =
      attrs
      |> Enum.into(%{
        desc: "some desc",
        name: "some name",
        creator: user.id,
        owner: user.id
      })
      |> SimpleTeamTodo.Todo.create_project()

    project
  end

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    user = user_fixture()
    project = project_fixture()

    {:ok, task} =
      attrs
      |> Enum.into(%{
        desc: "some desc",
        name: "some name",
        project: project.id,
        creator: user.id,
        owner: user.id
      })
      |> SimpleTeamTodo.Todo.create_task()

    task
  end
end
