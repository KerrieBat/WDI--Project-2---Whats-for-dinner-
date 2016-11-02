class Recipe <ActiveRecord::Base
  has_many :recipes_categories
  belongs_to :user
end
