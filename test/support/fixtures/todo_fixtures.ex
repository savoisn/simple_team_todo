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

  @doc """
  Generate a task with 2 child.
  """
  def task_with_child(attrs \\ %{}) do
    user = user_fixture()
    project1 = project_fixture()

    {:ok, task1} =
      attrs
      |> Enum.into(%{
        desc: "some desc1",
        name: "some name1",
        project: project1.id,
        creator: user.id,
        owner: user.id
      })
      |> SimpleTeamTodo.Todo.create_task()

    {:ok, task2} =
      attrs
      |> Enum.into(%{
        desc: "some desc2",
        name: "some name2",
        project: project1.id,
        creator: user.id,
        owner: user.id,
        parent: task1.id
      })
      |> SimpleTeamTodo.Todo.create_task()

    {:ok, task3} =
      attrs
      |> Enum.into(%{
        desc: "some desc3",
        name: "some name3",
        project: project1.id,
        creator: user.id,
        owner: user.id,
        parent: task1.id
      })
      |> SimpleTeamTodo.Todo.create_task()

    [task1, task2, task3]
  end

  @doc """
  Generate a 5 tasks in 2 different projects.
  """
  def task_and_project_fixture(attrs \\ %{}) do
    user = user_fixture()
    project1 = project_fixture()

    {:ok, task1} =
      attrs
      |> Enum.into(%{
        desc: "some desc1",
        name: "some name1",
        project: project1.id,
        creator: user.id,
        owner: user.id
      })
      |> SimpleTeamTodo.Todo.create_task()

    {:ok, task2} =
      attrs
      |> Enum.into(%{
        desc: "some desc2",
        name: "some name2",
        project: project1.id,
        creator: user.id,
        owner: user.id
      })
      |> SimpleTeamTodo.Todo.create_task()

    project2 = project_fixture()

    {:ok, task3} =
      attrs
      |> Enum.into(%{
        desc: "some desc3",
        name: "some name3",
        project: project2.id,
        creator: user.id,
        owner: user.id
      })
      |> SimpleTeamTodo.Todo.create_task()

    {:ok, task4} =
      attrs
      |> Enum.into(%{
        desc: "some desc4",
        name: "some name4",
        project: project2.id,
        creator: user.id,
        owner: user.id
      })
      |> SimpleTeamTodo.Todo.create_task()

    {:ok, task5} =
      attrs
      |> Enum.into(%{
        desc: "some desc5",
        name: "some name5",
        project: project2.id,
        creator: user.id,
        owner: user.id
      })
      |> SimpleTeamTodo.Todo.create_task()

    p1 = %{id: project1.id, tasks: [task1, task2]}
    p2 = %{id: project2.id, tasks: [task3, task4, task5]}

    {p1, p2}
  end
end
