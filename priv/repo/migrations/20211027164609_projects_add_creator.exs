defmodule SimpleTeamTodo.Repo.Migrations.ProjectsAddCreator do
  use Ecto.Migration

  def change do
    alter table("projects") do
      add :creator, :id
    end
  end
end
