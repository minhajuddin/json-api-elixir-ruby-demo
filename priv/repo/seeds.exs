# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TB.Repo.insert!(%TB.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TB.Repo
alias TB.Blog.{Post, Comment}

post = Repo.insert! %Post{title: "Hello, World!", body: "My first blog post"}


Repo.insert! %Comment{body: "Wow, nice post", post_id: post.id}
Repo.insert! %Comment{body: "meh.", post_id: post.id}
Repo.insert! %Comment{body: "Good stuff", post_id: post.id}
