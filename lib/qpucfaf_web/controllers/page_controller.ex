defmodule QpucfafWeb.PageController do
  use QpucfafWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
