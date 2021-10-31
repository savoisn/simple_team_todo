defmodule SimpleTeamTodo.Repo do
  use Ecto.Repo,
    otp_app: :simple_team_todo,
    adapter: Ecto.Adapters.Postgres
end
