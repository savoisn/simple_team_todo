defmodule SimpleTeamTodo.Repo.Migrations.UpdateTask do
  use Ecto.Migration

  def change do
    alter table("tasks") do
      remove :previous_child, :id
      remove :next_child, :id
      add :order_id, :decimal
    end
  end
end
