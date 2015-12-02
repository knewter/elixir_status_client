# ElixirStatusClient

This is a client library to fetch data from the
[ElixirStatus](http://www.elixirstatus.com) website using Floki to parse the
data into a structured format, and using HTTPoison to fetch the data, turning
the website into a `Stream` of posts.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `elixir_status_client` to your list of dependencies in `mix.exs`:

        def deps do
          [{:elixir_status_client, "~> 0.0.1"}]
        end

  2. Ensure `elixir_status_client` is started before your application:

        def application do
          [applications: [:elixir_status_client]]
        end

## Usage

In general, you can just use it as follows:

```elixir
ElixirStatusClient.posts
|> Stream.take(10)
|> Enum.to_list
```
