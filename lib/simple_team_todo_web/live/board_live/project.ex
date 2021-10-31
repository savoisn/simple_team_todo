defmodule SimpleTeamTodoWeb.BoardLive.Project do
  use SimpleTeamTodoWeb, :live_view
  alias SimpleTeamTodo.Todo
  require Logger

  def mount(%{"id" => id}, _session, socket) do
    Logger.info(id)

    project = Todo.get_project!(id)

    tasks = [
      %Todo.Task{name: "task1", desc: "desc1"},
      %Todo.Task{name: "task2", desc: "desc2"}
    ]

    {:ok, assign(socket, %{project: project, tasks: tasks})}
  end

  # def handle_event("event-clicked", _, socket) do
  # Logger.info("clicked")
  # {:noreply, socket}
  # end

  # def handle_params(params, _uri, socket) do
  # {:noreply, socket}
  # end
end
