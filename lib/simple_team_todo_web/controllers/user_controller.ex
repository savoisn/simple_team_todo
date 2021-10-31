defmodule SimpleTeamTodoWeb.UserController do
  use SimpleTeamTodoWeb, :controller

  alias SimpleTeamTodo.Accounts

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end
end
