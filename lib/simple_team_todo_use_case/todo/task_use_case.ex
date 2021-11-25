defmodule SimpleTeamTodoUseCase.Todo.TaskUseCase do
  alias SimpleTeamTodo.Todo
  alias SimpleTeamTodo.Todo.Task

  def get_tasks_by_project_sorted_by_user_pref(project) do
    Todo.project_tasks_user_ordered(project.id, asc: :order_id)
  end

  def insert_task_just_after(task, previous) do
    Todo.project_tasks_user_ordered(task.id, asc: :order_id)
  end

  def decimal_to_integer(decimal) do
    decimal
    |> Decimal.round() 
    |> Decimal.to_integer()
  end

  def search_task(i, tasks) do
    Enum.at(tasks, i)
  end

  def get_next_task(tasks, task) do
    order_id = for x <- tasks do
      id = x.order_id

      decimal_to_integer(id)
    end

    order_id = Enum.with_index(order_id)

    official = decimal_to_integer(task.order_id)

    queue = for {value, iteration} <- order_id do
      if value == official do
        next = search_task(iteration+1, tasks)
      end
    end

    next_task = Enum.filter(queue, & !is_nil(&1)) 
  
    next_task
    |> Enum.at(0)
  end
end
