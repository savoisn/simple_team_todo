defmodule SimpleTeamTodo.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string
      add :desc, :string
      add :owner, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:projects, [:owner])
  end
end
