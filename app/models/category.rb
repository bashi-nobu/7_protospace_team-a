class Category < ActiveRecord::Base
  validates :name,length:{maximum:50}
  has_many :prototypes, through: :prototype_categories
  has_many :prototype_categories, dependent: :destroy
end

