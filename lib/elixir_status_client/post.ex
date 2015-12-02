defmodule ElixirStatusClient.Post do
  defstruct [:avatar, :title, :meta, :body]

  defmodule Meta do
    defstruct [:date, :author]
  end
end
