class Recipe <ActiveRecord::Base
  has_many :links
  has_many :categories, through: :links

  belongs_to :user
end
