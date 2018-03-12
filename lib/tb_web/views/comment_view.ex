defmodule TBWeb.CommentView do
  use JSONAPI.View, type: "comments"

  def fields do
    [:body]
  end

  def render("index.json", %{comments: comments, conn: conn, params: params}) do
    TBWeb.CommentView.index(comments, conn, params)
    |> IO.inspect(label: "CCCCCCCCCCCCCCCCCCCC")
  end

end
