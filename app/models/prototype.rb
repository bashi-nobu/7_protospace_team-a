class Prototype < ActiveRecord::Base
  belongs_to :user
  has_many :captured_images, dependent: :destroy
  has_many :categories, through: :prototype_categories
  has_many :prototype_categories, dependent: :destroy
  accepts_nested_attributes_for :captured_images, reject_if: :reject_sub_images

  validates :title,
            :catch_copy,
            :concept,
            presence: true

  def reject_sub_images(attributed)
    attributed['content'].blank?
  end

  def set_main_thumbnail
    captured_images.main.first.content
  end

  def posted_date
    created_at.strftime('%b %d %a')
  end

  def save_categories(tags)
    current_tags = self.categories.pluck(:name) unless self.categories.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # Destroy old taggings:
    old_tags.each do |old_name|
      self.categories.delete Category.find_by(name:old_name)
    end

    # Create new taggings:
    new_tags.each do |new_name|
      prototype_category = Category.find_or_create_by(name:new_name)
      self.categories << prototype_category unless new_name == ''
    end
  end
end
