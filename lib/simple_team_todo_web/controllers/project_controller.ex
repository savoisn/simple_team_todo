defmodule SimpleTeamTodoWeb.ProjectController do
  use SimpleTeamTodoWeb, :controller

  alias SimpleTeamTodo.Todo
  alias SimpleTeamTodo.Todo.Project
  alias SimpleTeamTodo.Accounts

  def index(conn, _params) do
    projects = Todo.list_projects()
    render(conn, "index.html", projects: projects)
  end

  def new(conn, _params) do
    changeset = Todo.change_project(%Project{})

    ownerOrCreator = Accounts.list_users()
    ownerOrCreator_id = Enum.map(ownerOrCreator, fn x -> [key: x.email, value: x.id] end)

    render(conn, "new.html",
      changeset: changeset,
      creator: ownerOrCreator_id,
      owner: ownerOrCreator_id
    )
  end

  def create(conn, %{"project" => project_params}) do
    case Todo.create_project(project_params) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project created successfully.")
        |> redirect(to: Routes.project_path(conn, :show, project))

      {:error, %Ecto.Changeset{} = changeset} ->
        ownerOrCreator = Accounts.list_users()
        ownerOrCreator_id = Enum.map(ownerOrCreator, fn x -> [key: x.email, value: x.id] end)

        render(conn, "new.html",
          changeset: changeset,
          creator: ownerOrCreator_id,
          owner: ownerOrCreator_id
        )
    end
  end

  def show(conn, %{"id" => id}) do
    project = Todo.get_project!(id)
    render(conn, "show.html", project: project)
  end

  def edit(conn, %{"id" => id}) do
    project = Todo.get_project!(id)
    changeset = Todo.change_project(project)

    ownerOrCreator = Accounts.list_users()
    ownerOrCreator_id = Enum.map(ownerOrCreator, fn x -> [key: x.email, value: x.id] end)

    render(conn, "edit.html",
      project: project,
      changeset: changeset,
      creator: ownerOrCreator_id,
      owner: ownerOrCreator_id
    )
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = Todo.get_project!(id)

    case Todo.update_project(project, project_params) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project updated successfully.")
        |> redirect(to: Routes.project_path(conn, :show, project))

      {:error, %Ecto.Changeset{} = changeset} ->
        ownerOrCreator = Accounts.list_users()
        ownerOrCreator_id = Enum.map(ownerOrCreator, fn x -> [key: x.email, value: x.id] end)

        render(conn, "edit.html", %{
          project: project,
          changeset: changeset,
          creator: ownerOrCreator_id,
          owner: ownerOrCreator_id
        })
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Todo.get_project!(id)
    {:ok, _project} = Todo.delete_project(project)

    conn
    |> put_flash(:info, "Project deleted successfully.")
    |> redirect(to: Routes.project_path(conn, :index))
  end
end
