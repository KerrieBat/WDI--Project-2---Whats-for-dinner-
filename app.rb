
require 'pry'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'fog'
require 'sinatra'
# require 'sinatra/reloader'
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

  def execute_statement(sql)
    results = ActiveRecord::Base.connection.exec_query(sql)

        # results = ActiveRecord::Base.connection.execute(sql)
        if results.present?
            return results
        else
            return nil
        end
    end

end
#
get '/' do
  if Recipe.last
    # get latest entry from recipes table
    @latest = Recipe.last
    @username = User.find_by(id: @latest.user_id)
  end
  erb :home
end

  # if click on 'get dinner idea'
get '/recipe/get' do

  redirect to '/session/new' if !logged_in?

  erb :get_dinner
end

get '/recipe/options' do
  # search for options from inputs
  # if search by name
  if params[:recipe_search]

    @recipes = Recipe.where("recipe_name like ?", "%#{params[:recipe_search]}%")

  elsif params[:category]
    # search for recipes which meet requirements.

    # # Recipe.run_sql
# first get all the selected checkboxes and set to a variable to use in the sql statement
    if params.include?('hot')
      hotid = Category.find_by(category_name: 'hot').id
    end
    if params.include?('healthy')
      healthyid = Category.find_by(category_name: 'healthy').id
    end
    if params.include?('cold')
      coldid = Category.find_by(category_name: 'cold').id
    end
    if params.include?('vegetarian')
      vegetarianid = Category.find_by(category_name: 'vegetarian').id
    end
    if params.include?('no_cook')
      rawid = Category.find_by(category_name: 'no_cook').id
    end
    if params.include?('gluten_free')
      glutenid = Category.find_by(category_name: 'gluten_free').id
    end
    if params.include?('dairy_free')
      dairyid = Category.find_by(category_name: 'dairy_free').id
    end
    if params.include?('nightshade_free')
      shadeid = Category.find_by(category_name: 'nightshade_free').id
    end
    if params.include?('spicy')
      spicyid = Category.find_by(category_name: 'spicy').id
    end
    if params.include?('kid_friendly')
      kidid = Category.find_by(category_name: 'kid_friendly').id
    end
    if params.include?('will_impress')
      impressid = Category.find_by(category_name: 'will_impress').id
    end
    if params.include?('less_than_30')
      quickid = Category.find_by(category_name: 'less_than_30').id
    end
@recipe = execute_statement("SELECT recipes.recipe_name, links.category_id FROM recipes JOIN links ON recipes.id = links.recipe_id JOIN categories ON categories.id = links.category_id WHERE links.category_id IN (#{hotid}, #{coldid}, #{spicyid})")

    # @recipe = Recipe.run_sql("SELECT recipes.recipe_name, links.category_id FROM recipes JOIN links ON recipes.id = links.recipe_id JOIN categories ON categories.id = links.category_id WHERE links.category_id = #{hotid} OR links.category_id = coldid OR links.category_id = rawid OR links.category_id = quickid OR links.category_id = vegetarianid OR links.category_id = kidid OR links.category_id = spicyid OR links.category_id = shadeid OR links.category_id = dairyid OR links.category_id = glutenid OR links.category_id = impressid OR links.category_id = healthyid;")


  else
    @recipes = Recipe.all
  end

  erb :dinner_options
end

# display the recipe
get '/get_recipe' do
# binding.pry
  @recipe = Recipe.find_by(recipe_name: params[:recipe_name])
  @username = User.find_by(id: @recipe.user_id)
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

  new_dinner.save

  redirect to '/'
end

get '/recipe/plan' do
  redirect to '/session/new' if !logged_in?

  erb :plan_week
end


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
