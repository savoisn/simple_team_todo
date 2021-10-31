defmodule SimpleTeamTodo.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :string
      add :desc, :string
      add :project, references(:projects, on_delete: :nothing)
      add :creator, references(:users, on_delete: :nothing)
      add :owner, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:project])
    create index(:tasks, [:creator])
    create index(:tasks, [:owner])
  end
end
