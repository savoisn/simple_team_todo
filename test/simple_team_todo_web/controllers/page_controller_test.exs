defmodule SimpleTeamTodoWeb.PageControllerTest do
  use SimpleTeamTodoWeb.ConnCase, async: true

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
