defmodule QpucfafWeb.GamesController do
  use QpucfafWeb, :controller

  # GET /games
  def index(conn, _params) do
    games = GamesServer.all() |> Map.values()
    render(conn, "index.html", games: games)
  end

  # GET /games/:game_id
  def show(conn, %{"game_id" => game_id}) do
    case GamesServer.get_game(game_id) do
      nil ->
        conn
        |> put_flash(:error, "Game not found")
        |> redirect(to: ~p"/games")

      game ->
        render(conn, "show.html", game: game)
    end
  end

  # POST /games
  def create(conn, _params) do
    game = GamesServer.create_game()

    # Redirect to the new game's detail page
    redirect(conn, to: ~p"/games/#{game.id}")
  end
end
