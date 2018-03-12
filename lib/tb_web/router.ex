defmodule TBWeb.Router do
  use TBWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", TBWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  # Other scopes may use custom stacks.
  scope "/api", TBWeb do
    pipe_through(:api)
    resources("/posts", PostController, except: [:new, :edit])
    resources("/comments", CommentController, except: [:new, :edit])
  end
end
