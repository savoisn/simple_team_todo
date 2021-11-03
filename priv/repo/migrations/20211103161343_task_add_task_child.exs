defmodule SimpleTeamTodo.Repo.Migrations.TaskAddTaskChild do
  use Ecto.Migration

  def change do
    # solution 1 : 
    # |-----------------
    # | task
    # |-----------------
    # | id
    # | parent_task
    # | previous_child
    # | next_child
    # |-----------------
    alter table("tasks") do
      add :parent, :id
      add :previous_child, :id
      add :next_child, :id
    end
  end
end
