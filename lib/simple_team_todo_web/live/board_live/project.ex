defmodule SimpleTeamTodoWeb.BoardLive.Project do
  use SimpleTeamTodoWeb, :live_view
  alias SimpleTeamTodo.Todo
  require Logger

  def mount(%{"id" => id}, _session, socket) do
    Logger.info(id)

    project = Todo.get_project!(id)

    tasks = Todo.list_tasks_by_project(project.id)

    {:ok, assign(socket, %{project: project, tasks: tasks})}
  end
end
