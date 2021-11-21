defmodule SimpleTeamTodo.TodoTest do
  use SimpleTeamTodo.DataCase, async: true

  alias SimpleTeamTodo.Todo
  import SimpleTeamTodo.AccountsFixtures

  import Assertions

  describe "projects" do
    alias SimpleTeamTodo.Todo.Project

    import SimpleTeamTodo.TodoFixtures

    @invalid_attrs %{desc: nil, name: nil}

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Todo.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Todo.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      user = user_fixture()
      valid_attrs = %{desc: "some desc", name: "some name", owner: user.id, creator: user.id}
      assert {:ok, %Project{} = project} = Todo.create_project(valid_attrs)
      assert project.desc == "some desc"
      assert project.name == "some name"
      assert project.owner == user.id
      assert project.creator == user.id
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      update_attrs = %{desc: "some updated desc", name: "some updated name"}

      assert {:ok, %Project{} = project} = Todo.update_project(project, update_attrs)
      assert project.desc == "some updated desc"
      assert project.name == "some updated name"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_project(project, @invalid_attrs)
      assert project == Todo.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Todo.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Todo.change_project(project)
    end
  end

  describe "tasks" do
    alias SimpleTeamTodo.Todo.Task

    import SimpleTeamTodo.TodoFixtures

    @invalid_attrs %{desc: nil, name: nil}

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Todo.list_tasks() == [task]
    end

    test "list_tasks_by_project/1 returns all tasks" do
      {
        %{id: p1, tasks: [task1, task2]},
        %{id: p2, tasks: [task3, task4, task5]}
      } = task_and_project_fixture()

      assert_lists_equal(Todo.list_tasks_by_project(p1), [task1, task2])
      assert_lists_equal(Todo.list_tasks_by_project(p2), [task3, task4, task5])
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Todo.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      user = user_fixture()
      project = project_fixture()

      valid_attrs = %{
        desc: "some desc",
        name: "some name",
        project: project.id,
        owner: user.id,
        creator: user.id
      }

      assert {:ok, %Task{} = task} = Todo.create_task(valid_attrs)
      assert task.desc == "some desc"
      assert task.name == "some name"
      assert task.project == project.id
      assert task.owner == user.id
      assert task.creator == user.id
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{desc: "some updated desc", name: "some updated name"}

      assert {:ok, %Task{} = task} = Todo.update_task(task, update_attrs)
      assert task.desc == "some updated desc"
      assert task.name == "some updated name"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_task(task, @invalid_attrs)
      assert task == Todo.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Todo.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Todo.change_task(task)
    end

    test "add child task to task" do
      [task1, task2, task3] = task_with_child()
      assert task2.parent == task1.id
      assert task3.parent == task1.id
    end

    test "tasks are in the order the user defined" do
      {project, _} = task_with_order()

      [task1, task2, task3, task4] = Todo.project_tasks_user_ordered(project.id, asc: :order_id)
      assert task1.order_id < task2.order_id
      assert task2.order_id < task3.order_id
      assert task3.order_id < task4.order_id
    end
  end
end
