defmodule SimpleTeamTodoWeb.BoardLive.Project do
  use SimpleTeamTodoWeb, :live_view
  alias SimpleTeamTodo.Todo
  alias SimpleTeamTodo.Todo.Task
  require Logger

  def mount(%{"id" => id}, _session, socket) do
    Logger.info(id)
    project = Todo.get_project!(id)
    tasks = Todo.list_tasks_by_project(project.id)
    {:ok, assign(socket, %{project: project, tasks: tasks})}
  end

  def handle_params(params, _session, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :create, _params) do
    IO.inspect("Create")

    socket
    |> assign(:page_title, "New Task")
    |> assign(:task, %Task{project: socket.assigns.project.id})
  end

  defp apply_action(socket, action, _params) do
    IO.inspect(action)

    socket
    |> assign(:page_title, "New Task")
  end
end
