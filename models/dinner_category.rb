class Recipe_category <ActiveRecord::Base
  belongs_to :recipe
  belongs_to :categories
end
