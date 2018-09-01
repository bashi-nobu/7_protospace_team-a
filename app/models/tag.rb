class Tag < ActiveRecord::Base
  has_many :tag_prototype
  has_many :posts, through: :tag_prototype
end
