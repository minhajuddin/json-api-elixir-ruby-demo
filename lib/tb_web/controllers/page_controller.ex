defmodule TBWeb.PageController do
  use TBWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
