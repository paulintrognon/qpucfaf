defmodule Game do
  @moduledoc """
  Represents a single game instance.
  """

  defstruct [:id, :created_at]

  @doc """
  Creates a new Game struct with a random 10-character ID and current timestamp.
  """
  def new do
    %__MODULE__{
      id: generate_id(),
      created_at: DateTime.utc_now()
    }
  end

  defp generate_id do
    :crypto.strong_rand_bytes(8)
    |> Base.url_encode64(padding: false)
    |> binary_part(0, 10)
  end
end
