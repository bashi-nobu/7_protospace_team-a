class PrototypesController < ApplicationController
  before_action :set_prototype, only: :show

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
    @tag = Tag.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
      @tag_params = tag_params.merge(user_id: current_user.id)
      @tag = Tag.new(@tag_params)
      if @prototype.save & @tag.save
        redirect_to :root, notice: 'New prototype was successfully created'
      else
        redirect_to ({ action: new }), alert: 'YNew prototype was unsuccessfully created'
     end
  end

  def show
    @tag = Tag.new
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:content, :status]
    )
  end

  def tag_params
    params.require(:prototype).permit(:tag_name)
  end
end
