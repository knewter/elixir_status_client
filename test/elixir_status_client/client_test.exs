defmodule ElixirStatusClient.ClientTest do
  use ExUnit.Case
  alias ElixirStatusClient.Client

  test "returns a stream of the first page of results" do
    posts =
      Client.posts()
      |> Stream.take(10)
      |> Enum.to_list

    [first_post|_] = posts
    assert first_post.body
    assert length(posts) == 10
  end

  test "walks the pagination links to get more posts" do
    posts =
      Client.posts()
      |> Stream.take(30)
      |> Enum.to_list

    [first_post|_] = posts
    assert first_post.body
    assert length(posts) == 30
  end
end
