defmodule ElixirStatusClient.Parser do
  alias ElixirStatusClient.Post

  def posts(html) do
    html
    |> Floki.find("div.post[data-posting-uid]")
    |> Enum.map(&post/1)
  end

  def post(post) do
    %Post{
      title: title(post),
      avatar: avatar(post),
      body: body(post),
      meta: meta(post)
    }
  end

  def meta(post) do
    %Post.Meta{
      date: date(post),
      author: author(post)
    }
  end

  def title(post) do
    text_for(post, ".post-title")
  end

  def avatar(post) do
    post
    |> Floki.find(".post-avatar .image")
    |> Floki.attribute("style")
    |> (fn
         ([style]) ->
           Regex.replace(~r/background-image: url\((.*)\)/, style, "\\1")
         (x) ->
           ""
       end).()
  end

  def body(post) do
    text_for(post, ".post-body")
  end

  def date(post) do
    text_for(post, ".post-date")
  end

  def author(post) do
    text_for(post, ".post-author a")
  end

  defp text_for(post, path) do
    post
    |> Floki.find(path)
    |> Floki.text
    |> String.strip
  end
end
