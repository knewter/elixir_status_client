defmodule ElixirStatusClient.Client do
  @url "http://elixirstatus.com"
  alias ElixirStatusClient.Parser

  def posts do
    fetch_stream_state = fn(url) ->
      response = HTTPoison.get!(url)
      body = response.body
      posts_page = Parser.posts(body)
      next_page_url = Parser.next_page_url(body)
      {posts_page, next_page_url}
    end
    # Grab the first page of [ElixirStatus](http://www.elixirstatus.com)
    start = fn ->
      fetch_stream_state.(@url)
    end
    pop_item = fn state={[head|tail], next} ->
      new_state = {tail, next}
      {[head], new_state}
    end
    fetch_next_page = fn {[], next} ->
      state = fetch_stream_state.(@url <> next)
      pop_item.(state)
    end
    next_item = fn
      state={[], nil}  -> {:halt, state}
      state={[], next} -> fetch_next_page.(state)
      state            -> pop_item.(state)
    end
    stop = fn(_state) -> end

    Stream.resource(start, next_item, stop)
  end
end
