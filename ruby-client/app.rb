require 'bundler/setup'
Bundler.require(:default)

module Blog
  # this is an "abstract" base class that
  class Base < JsonApiClient::Resource
    # set the api base url in an abstract base class
    self.site = "http://localhost:4000/api"
  end

  class Post < Base
  end

  class Comment < Base
  end

end

puts Blog::Post.all
binding.pry
