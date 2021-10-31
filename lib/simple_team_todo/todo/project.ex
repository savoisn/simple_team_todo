defmodule SimpleTeamTodo.Todo.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :desc, :string
    field :name, :string
    field :creator, :id
    field :owner, :id

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :desc, :creator, :owner])
    |> validate_required([:name, :desc, :creator, :owner])
  end
end
