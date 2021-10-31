defmodule SimpleTeamTodo.Todo.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :desc, :string
    field :name, :string
    field :project, :id
    field :creator, :id
    field :owner, :id

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :desc, :project, :owner, :creator])
    |> validate_required([:name, :desc, :project, :owner, :creator])
  end
end
