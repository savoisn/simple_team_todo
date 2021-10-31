defmodule SimpleTeamTodoWeb.PageController do
  use SimpleTeamTodoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
