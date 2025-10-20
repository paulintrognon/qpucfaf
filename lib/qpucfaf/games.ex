defmodule Games do
  defstruct collection: %{}

  def new, do: %Games{}

  def create_game(%Games{collection: collection} = games) do
    game = Game.new()
    new_collection = Map.put(collection, game.id, game)
    {game, %Games{games | collection: new_collection}}
  end

  def get_game(%Games{collection: collection}, id) do
    Map.get(collection, id)
  end

  def clean(%Games{collection: collection} = games) do
    now = DateTime.utc_now()

    new_collection =
      collection
      |> Enum.filter(fn {_id, game} ->
        DateTime.diff(now, game.created_at, :second) < 30 * 24 * 3600
      end)
      |> Enum.into(%{})

    %Games{games | collection: new_collection}
  end
end
