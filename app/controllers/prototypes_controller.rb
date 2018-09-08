class PrototypesController < ApplicationController
  before_action :set_prototype, only: :show

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      redirect_to ({ action: new }), alert: 'YNew prototype was unsuccessfully created'
     end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy if prototype.user_id == current_user.id
    if prototype.destroy
      redirect_to :root, notice: "prototype #{params[:id]} was successfully deleted"
    else
      redirect_to ({ action: edit }), alert: "prototype #{params[:id]} was unsuccessfully deleted"
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
  prototype = Prototype.find(params[:id])
    if prototype.user_id == current_user.id
      prototype.update(prototype_params)
    end
    if prototype.update_attributes(prototype_params)
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      redirect_to ({ action: edit }), alert: 'YNew prototype was unsuccessfully created'
    end
  end

  def show
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
end
