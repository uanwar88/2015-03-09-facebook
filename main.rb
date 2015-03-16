require "sinatra"
require "sqlite3"
require 'json'
require 'pry'

DATABASE = SQLite3::Database.new("database.db")
DATABASE.results_as_hash = true

# Require all of the Ruby files in /models. :)
Dir["./models/*.rb"].each{ |file| require file }

get "/" do
  @current_user = User.find(1)
  @posts = Post.all
  erb :homepage
end

# Likes a post and returns some JSON upon success.
get "/like/:post_id" do
  @current_user = User.find(1)
  @current_user.like_post(params[:post_id])
  @post = Post.find(params[:post_id])

  result = {
    "success" => true,
    "post_id" => params[:post_id],
    "new_number_of_likes" => @post.likes
  }

  result.to_json
end

binding.pry
