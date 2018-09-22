class Category < ActiveRecord::Base
  validates :name,length:{maximum:50}
  has_many :prototypes, through: :prototypes_categories
  has_many :prototypes_categories, dependent: :destroy
end

