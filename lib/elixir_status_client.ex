defmodule ElixirStatusClient do
  alias ElixirStatusClient.Client
  defdelegate posts, to: Client
end
