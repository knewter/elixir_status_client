defmodule ElixirStatusClient.ParserTest do
  use ExUnit.Case
  alias ElixirStatusClient.Parser
  @html PathHelpers.test_file_path("elixirstatusindex.html") |> File.read!

  test "finding posts on elixirstatus" do
    posts = Parser.posts(@html)

    assert length(posts) == 20

    [first_post|_] = posts

    assert first_post.title =~ ~r/RethinkDB/
    assert first_post.avatar == "/images/github/ryanswapp.jpg"
    assert first_post.body =~ ~r/RethinkDB/
    assert first_post.meta.date == "28 Nov"
    assert first_post.meta.author =~ ~r/ryanswapp/
  end
end
