defmodule SimpleTeamTodoUseCase.Todo.TaskUseCase do
  alias SimpleTeamTodo.Todo
  alias SimpleTeamTodo.Todo.Task

  def get_tasks_by_project_sorted_by_user_pref(project) do
    Todo.project_tasks_user_ordered(project.id, asc: :order_id)
  end
end
