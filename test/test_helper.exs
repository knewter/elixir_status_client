ExUnit.start()

defmodule PathHelpers do
  def test_file_path do
    Path.expand("files", __DIR__)
  end

  def test_file_path(filename) do
    Path.join(test_file_path, filename)
  end
end
