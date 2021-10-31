defmodule SimpleTeamTodoWeb.TaskController do
  use SimpleTeamTodoWeb, :controller

  alias SimpleTeamTodo.Todo
  alias SimpleTeamTodo.Todo.Task
  alias SimpleTeamTodo.Accounts

  def index(conn, _params) do
    tasks = Todo.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Todo.change_task(%Task{})
    projects = Todo.list_projects()
    projects_name = Enum.map(projects, fn x -> [key: x.name, value: x.id] end)

    ownerOrCreator = Accounts.list_users()
    ownerOrCreator_id = Enum.map(ownerOrCreator, fn x -> [key: x.email, value: x.id] end)

    render(conn, "new.html", %{
      changeset: changeset,
      projects: projects_name,
      owner: ownerOrCreator_id,
      creator: ownerOrCreator_id
    })
  end

  def create(conn, %{"task" => task_params}) do
    case Todo.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        projects = Todo.list_projects()
        projects_name = Enum.map(projects, fn x -> [key: x.name, value: x.id] end)
        ownerOrCreator = Accounts.list_users()
        ownerOrCreator_id = Enum.map(ownerOrCreator, fn x -> [key: x.email, value: x.id] end)

        render(conn, "new.html",
          changeset: changeset,
          projects: projects_name,
          owner: ownerOrCreator_id,
          creator: ownerOrCreator_id
        )
    end
  end

  def show(conn, %{"id" => id}) do
    task = Todo.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Todo.get_task!(id)
    changeset = Todo.change_task(task)
    projects = Todo.list_projects()
    projects_name = Enum.map(projects, fn x -> [key: x.name, value: x.id] end)

    ownerOrCreator = Accounts.list_users()
    ownerOrCreator_id = Enum.map(ownerOrCreator, fn x -> [key: x.email, value: x.id] end)

    render(conn, "edit.html",
      task: task,
      changeset: changeset,
      projects: projects_name,
      owner: ownerOrCreator_id,
      creator: ownerOrCreator_id
    )
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Todo.get_task!(id)

    case Todo.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        projects = Todo.list_projects()
        projects_name = Enum.map(projects, fn x -> [key: x.name, value: x.id] end)

        ownerOrCreator = Accounts.list_users()
        ownerOrCreator_id = Enum.map(ownerOrCreator, fn x -> [key: x.email, value: x.id] end)

        render(conn, "edit.html",
          task: task,
          changeset: changeset,
          projects: projects_name,
          owner: ownerOrCreator_id,
          creator: ownerOrCreator_id
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Todo.get_task!(id)
    {:ok, _task} = Todo.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
