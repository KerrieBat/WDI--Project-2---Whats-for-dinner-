
# good food hunting
require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require_relative 'db_config'
require_relative 'models/recipe'
require_relative 'models/category'
require_relative 'models/user'
require_relative 'models/link'

enable :sessions

helpers do

  def logged_in?
    !!current_user
  end

  def current_user
    User.find_by(id: session[:user_id])
  end
end

get '/' do

"hello world"
# get latest entry from recipes table
@latest = Recipe.last
@username = User.find_by(id: @latest.user_id)
  erb :home
end

# if click on 'get dinner idea'
get '/recipe/get' do

  redirect to '/session/new' if !logged_in?

  erb :get_dinner
end

# display the recipe
get '/recipe' do
@username =
@recipe =
  erb :recipe
end

get '/recipe/add' do
  redirect to '/session/new' if !logged_in?
  # @categories = Category.all

  erb :add_recipe
end

post '/recipe' do
  # add new recipe into table
  new_dinner = Recipe.new
  new_dinner.recipe_name = params[:recipe_name]
  new_dinner.description = params[:description]
  new_dinner.user_id = current_user.id
  new_dinner.recipe = params[:recipe]
  new_dinner.photo = params[:photo]
  # add all the checkbox values
  if params.include?('hot')
    category = Category.find_by(category_name: 'hot')
    new_dinner.categories << category
  end
  if params.include?('healthy')
    category = Category.find_by(category_name: 'healthy')
    new_dinner.categories << category
  end
  if params.include?('cold')
    category = Category.find_by(category_name: 'cold')
    new_dinner.categories << category
  end
  if params.include?('vegetarian')
    category = Category.find_by(category_name: 'vegetarian')
    new_dinner.categories << category
  end
  if params.include?('no_cook')
    category = Category.find_by(category_name: 'no_cook')
    new_dinner.categories << category
  end
  if params.include?('gluten_free')
    category = Category.find_by(category_name: 'gluten_free')
    new_dinner.categories << category
  end
  if params.include?('dairy_free')
    category = Category.find_by(category_name: 'dairy_free')
    new_dinner.categories << category
  end
  if params.include?('nightshade_free')
    category = Category.find_by(category_name: 'nightshade_free')
    new_dinner.categories << category
  end
  if params.include?('spicy')
    category = Category.find_by(category_name: 'spicy')
    new_dinner.categories << category
  end
  if params.include?('kid_friendly')
    category = Category.find_by(category_name: 'kid_friendly')
    new_dinner.categories << category
  end
  if params.include?('will_impress')
    category = Category.find_by(category_name: 'will_impress')
    new_dinner.categories << category
  end
  if params.include?('less_than_30')
    category = Category.find_by(category_name: 'less_than_30')
    new_dinner.categories << category
  end





  # ['hot', 'dessert',]
  # Category.all.each do |category|
  #   #the code here is called once for each user
  #   # user is accessible by 'user' variable
  #   # new_link = Link.new
  #   # if params[:category] != nil
  #   #   new_link.recipe_id = new_dinner.id
  #   #   new_link.category_id = category.category_id
  #   #   # new_link.vegetarian = true
  #   #   new_link.save
  #   # end
  #   # binding.pry
  # end
  # if params[:hot] == nil
  #   new_dinner.hot = false
  # else
  #   new_dinner.hot = true
  # end
  # if params[:cold] == nil
  #   new_dinner.cold = false
  # else
  #   new_dinner.cold = true
  # end
  # if params[:healthy] == nil
  #   new_dinner.healthy = false
  # else
  #   new_dinner.healthy = true
  # end
  # if params[:raw] == nil
  #   new_dinner.no_cook = false
  # else
  #   new_dinner.no_cook = true
  # end
  # if params[:gluten] == nil
  #   new_dinner.gluten_free = false
  # else
  #   new_dinner.gluten_free = true
  # end
  # if params[:nightshade] == nil
  #   new_dinner.nightshade_free = false
  # else
  #   new_dinner.nightshade_free = true
  # end
  # if params[:dairy] == nil
  #   new_dinner.dairy_free = false
  # else
  #   new_dinner.dairy_free = true
  # end
  # if params[:spicy] == nil
  #   new_dinner.spicy = false
  # else
  #   new_dinner.spicy = true
  # end
  # if params[:kids] == nil
  #   new_dinner.kid_friendly = false
  # else
  #   new_dinner.kid_friendly = true
  # end
  # if params[:impress] == nil
  #   new_dinner.will_impress = false
  # else
  #   new_dinner.will_impress = true
  # end
  # if params[:quick] == nil
  #   new_dinner.less_than_30 = false
  # else
  #   new_dinner.less_than_30 = true
  # end

  new_dinner.save
redirect to '/'
end

get '/recipe/plan' do
  redirect to '/session/new' if !logged_in?

  erb :plan_week
end

  #
# get '/dishes/new' do
#   redirect to '/session/new' if !logged_in?
#   # show the form only
#   @dishtype = Dishtype.all
#   erb :dishes_new
# end
#
# post '/dishes' do
#   redirect to '/session/new' if !logged_in?
#   # create the dish
#   # Dish.create(name: params[:name], image_url: params[:image_url])
#   # or can do
#   dish = Dish.new
#   dish.name = params[:name]
#   dish.image_url = params[:image_url]
#   dish.dishtype_id = params[:dishtype_id]
#
#   if dish.save
#     redirect to '/'
#   else
#     erb :dishes_new
#   # lays it out better and can specify or change entries easier
#
#
#     redirect to '/'
#   end
# end
#
# post '/comments' do
#   comment = Comment.new
# # binding.pry
#   comment.body = params[:body]
#
#   comment.dish_id = params[:dish_id]
#
#   comment.save
#   redirect to "/dishes/#{comment.dish_id}"
# end
#
# post '/dishtype' do
#   dishtype = Dishtype.new
#   #select from a pull down list
# end
#
# get '/dishes/:id' do
#   # show single dish
#   @dish = Dish.find_by(id: params[:id])
#   # or can say if belongs_to is in comment.rb
#   # @comments = @dish.comment
#   @comments = Comment.where(dish_id: @dish.id)
#   @dishtype = Dishtype.where(id: @dish.dishtype_id)
# # or @dish = Dish.find(params[:id])  ----find finds record on id automatically, find_by if want to find on another record
#   erb :dishes_show
# end
#
# show the edit dish form
# get '/dishes/:id/edit' do
#   @dish = Dish.find_by(id: params[:id])
#   @dishtype = Dishtype.where(id: @dish.dishtype_id)
#   @dishtype_list =Dishtype.all
#   # @dishtype = @dish.dishtype
#
#   erb :dishes_edit
# end

# # updating an existing dish
# post '/dishes/:id' do
#   dish = Dish.find_by(id: params[:id])
#   dish.update (name: params[:name], image_url: params[:image_url], dishtype_id: params[:dishtype_id])
#
#   redirect to "/dishes/#{ params[:id]}"
# end

# # delete an existing dish
# post '/dishes/:id/delete' do
#   dish = Dish.find_by(id: params[:id])
#   dish.destroy
#
#   redirect to '/'
# end
#
# sign in to new session
get '/session/new' do
  erb :session_new
end

# sign up to whats for dinner
get '/session/signup' do
  erb :session_new
end

post '/signup' do
  new_user = User.new
  new_user.email = params[:email]
  new_user.username = params[:username]
  new_user.password = params[:password]

  new_user.save
  @user = new_user.username
  session[:user_id] = new_user.id
  redirect to '/'
end

post '/session' do
  user = User.find_by(email: params[:email])

  if user && user.authenticate(params[:password])
    #you are fine, lets create a session for you
    session[:user_id] = user.id

    redirect to '/'
  else
    #who are you?
    erb :session_new
  end
end

delete '/session' do
  # clearing the session
  if session[:user_id] != nil
  session[:user_id] = nil
  end
  redirect to '/session/new'
end










#
# get '/search' do
#   movie = params[:movie_name]
#   multiresult = HTTParty.get("http://omdbapi.com/?s=#{movie}")
#   @movies = multiresult["Search"]
#   erb :options
# end
#
# get '/get_movie' do
#     movie = params[:movie_name]
#     # if movie selected is already in the localmovies database, then pull data from database,  otherwise get it from the API
#   if Movie.find_by(title: movie)
#     # yes its in the database, get data from there
#     movie_from_store = Movie.find_by(title: movie)
#     @movie_title = movie_from_store.title
#     @movie_plot = movie_from_store.plot
#     @movie_poster = movie_from_store.poster
#     @movie_year = movie_from_store.year
#     @rating = movie_from_store.rating
#     @cast = movie_from_store.actors
#     @director = movie_from_store.director
#   else
#     # no its not in the database, get it from API then store in database
#     result = HTTParty.get("http://omdbapi.com/?t=#{movie}")
# # binding.pry
#     if result["Response"] == "False"
#       @error = result["Error"]
#       # use page error showing error message
#       erb :error
#     else
#       # use std page
#       @movie_title = result["Title"]
#       @movie_plot = result["Plot"]
#       @movie_poster = result["Poster"]
#       @movie_year = result["Year"]
#       @rating = result["Rated"]
#       @cast = result["Actors"]
#       @director = result["Director"]
#
# # store results in local movies database
#
#       movie_to_store = Movie.new
#       movie_to_store.title = @movie_title
#       movie_to_store.plot = @movie_plot
#       movie_to_store.poster = @movie_poster
#       movie_to_store.year = @movie_year
#       movie_to_store.rating = @rating
#       movie_to_store.director = @director
#       movie_to_store.actors = @cast
#
#       movie_to_store.save
#
#     end
#   end
#   erb :index
# end
