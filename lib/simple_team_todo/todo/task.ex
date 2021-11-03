defmodule SimpleTeamTodo.Todo.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :desc, :string
    field :name, :string
    field :project, :id
    field :creator, :id
    field :owner, :id
    field :parent, :id
    field :previous_child, :id
    field :next_child, :id
    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [
      :name,
      :desc,
      :project,
      :owner,
      :creator,
      :parent,
      :previous_child,
      :next_child
    ])
    |> validate_required([:name, :desc, :project, :owner, :creator])
  end
end
