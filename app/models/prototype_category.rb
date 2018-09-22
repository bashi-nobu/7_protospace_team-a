class PrototypeCategory < ActiveRecord::Base
  belongs_to :prototype
  belongs_to :category
  validates :prototype_id,presence:true
  validates :category_id,presence:true
end
