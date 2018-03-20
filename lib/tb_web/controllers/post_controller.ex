defmodule TBWeb.PostController do
  use TBWeb, :controller

  alias TB.Blog
  alias TB.Blog.Post

  use PhoenixSwagger

  def swagger_definitions do
    %{
      User:
        swagger_schema do
          title("User")
          description("A user of the application")

          properties do
            name(:string, "Users name", required: true)
            id(:string, "Unique identifier", required: true)
            address(:string, "Home address")

            preferences(
              Schema.new do
                properties do
                  subscribe_to_mailing_list(:boolean, "mailing list subscription", default: true)
                  send_special_offers(:boolean, "special offers list subscription", default: true)
                end
              end
            )
          end

          example(%{
            name: "Joe",
            id: "123",
            address: "742 Evergreen Terrace"
          })
        end,
      Users:
        swagger_schema do
          title("Users")
          description("A collection of Users")
          type(:array)
          items(Schema.ref(:User))
        end,
      UserResponse:
        swagger_schema do
          title("UserResponse")
          description("Response schema for single user")
          property(:data, Schema.ref(:User), "The user details")
        end,
      UsersResponse:
        swagger_schema do
          title("UsersReponse")
          description("Response schema for multiple users")
          property(:data, Schema.array(:User), "The users details")
        end
    }
  end

  swagger_path(:index) do
    get("/api/users")
    summary("List Users")
    description("List all users in the database")
    produces("application/json")

    response(
      200,
      "OK",
      Schema.ref(:UsersResponse),
      example: %{
        data: [
          %{
            id: 1,
            name: "Joe",
            email: "Joe6@mail.com",
            inserted_at: "2017-02-08T12:34:55Z",
            updated_at: "2017-02-12T13:45:23Z"
          },
          %{
            id: 2,
            name: "Jack",
            email: "Jack7@mail.com",
            inserted_at: "2017-02-04T11:24:45Z",
            updated_at: "2017-02-15T23:15:43Z"
          }
        ]
      }
    )
  end

  # action_fallback TBWeb.FallbackController

  def index(conn, params) do
    posts = Blog.list_posts()
    render(conn, "index.json", %{posts: posts, conn: conn, params: params})
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- Blog.create_post(post_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", post_path(conn, :show, post))
      |> render("show.json", post: post)
    end
  end

  def show(conn, %{"id" => id} = params) do
    post = Blog.get_post!(id)
    render(conn, "show.json", %{post: post, conn: conn, params: params})
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)

    with {:ok, %Post{} = post} <- Blog.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)

    with {:ok, %Post{}} <- Blog.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
