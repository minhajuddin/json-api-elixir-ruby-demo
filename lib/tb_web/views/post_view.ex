defmodule TBWeb.PostView do
  use JSONAPI.View, type: "posts"

  alias TBWeb.PostView

  def render("index.json", %{posts: posts, conn: conn, params: params}) do
    TBWeb.PostView.index(posts, conn, params)
    |> IO.inspect(label: "AAAH")
  end

  def render("show.json", %{post: post, conn: conn, params: params}) do
    TBWeb.PostView.show(post, conn, params)
  end

  def fields do
    [:title, :body, :excerpt]
  end

  def excerpt(post, _conn) do
    String.slice(post.body, 0..5)
  end

  def meta(data, _conn) do
    # this will add meta to each record
    # To add meta as a top level property, pass as argument to render function (shown below)
    %{inserted_at: data.inserted_at}
  end

  def relationships do
    # The post's author will be included by default
    [comments: TBWeb.CommentView]
  end
end
