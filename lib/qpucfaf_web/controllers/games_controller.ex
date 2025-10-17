defmodule QpucfafWeb.GamesController do
  use QpucfafWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
