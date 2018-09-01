class TagPrototype < ActiveRecord::Base
  belongs_to :prototypes, :tags
end
