defmodule SimpleTeamTodoUseCase.TodoTest do
  use SimpleTeamTodo.DataCase, async: true

  alias SimpleTeamTodoUseCase.Todo.TaskUseCase

  describe "tasks" do
    import SimpleTeamTodo.TodoFixtures

    test "tasks are in the order the user defined" do
      {project, _} = task_with_order()

      [task1, task2, task3, task4] = TaskUseCase.get_tasks_by_project_sorted_by_user_pref(project)
      assert task1.order_id < task2.order_id
      assert task2.order_id < task3.order_id
      assert task3.order_id < task4.order_id
    end

    test "insert task between 2 other tasks" do
      {project, _} = task_with_order()
      [task1, task2, task3, task4] = TaskUseCase.get_tasks_by_project_sorted_by_user_pref(project)
      task = %Task{}
      TaskUseCase.insert_task_just_after(task, task2)

      [task1, task2, task3, task4, task5] =
        TaskUseCase.get_tasks_by_project_sorted_by_user_pref(project)

      assert task == task3
    end
  end
end
