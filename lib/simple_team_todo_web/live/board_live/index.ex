defmodule SimpleTeamTodoWeb.BoardLive.Index do
  use SimpleTeamTodoWeb, :live_view
  alias SimpleTeamTodo.Todo
  require Logger

  def mount(_params, _session, socket) do
    # Logger.info(session)
    # project = 
    # tasks = Todo.list_tasks_by_project(project)
    projects = Todo.list_projects()
    {:ok, assign(socket, :projects, projects)}
  end

  def handle_event("event-clicked", _, socket) do
    Logger.info("clicked")
    {:noreply, socket}
  end
end
