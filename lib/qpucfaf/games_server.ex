defmodule GamesServer do
  @moduledoc """
  A GenServer that holds all games in memory.
  Works like a singleton stateful object.
  """

  use GenServer

  ## ─── Public API ────────────────────────────────

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, Games.new(), name: __MODULE__)
  end

  @doc "Create and store a new game."
  def create_game do
    GenServer.call(__MODULE__, :create_game)
  end

  @doc "Get a game by its ID."
  def get_game(id) do
    GenServer.call(__MODULE__, {:get_game, id})
  end

  @doc "Clean up games older than 1 month."
  def clean do
    GenServer.cast(__MODULE__, :clean)
  end

  @doc "Return all games."
  def all do
    GenServer.call(__MODULE__, :all)
  end

  ## ─── GenServer Callbacks ───────────────────────

  def init(initial_state), do: {:ok, initial_state}

  def handle_call(:create_game, _from, games) do
    {game, new_games} = Games.create_game(games)
    {:reply, game, new_games}
  end

  def handle_call({:get_game, id}, _from, games) do
    {:reply, Games.get_game(games, id), games}
  end

  def handle_call(:all, _from, games) do
    {:reply, games.collection, games}
  end

  def handle_cast(:clean, games) do
    {:noreply, Games.clean(games)}
  end
end
