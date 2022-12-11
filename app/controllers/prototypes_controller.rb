class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]

  def index # GET
    @prototypes = Prototype.all.includes(:user).order("id DESC")
  end

  def new # GET
    @prototype = Prototype.new
  end

  def create # POST
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def show # GET
    set_prototype(params[:id])
    @comment = Comment.new
  end

  def edit # GET
    if set_prototype(params[:id])
      unless @prototype.user.id == current_user.id
        redirect_to action: :index
      end
    end
  end

  def update # PATCH
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy # DELETE
    if set_prototype(params[:id])
      if @prototype.user.id == current_user.id
        @prototype.destroy
        redirect_to action: :index
      else
        redirect_to action: :show
      end
    end
  end


  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype(protoId)
    if Prototype.exists?(id: protoId)
      @prototype = Prototype.find(protoId)
      @comments = @prototype.comments.includes(:user).order("id DESC")
      return true
    else
      render '/notexist'
      return false
      # redirect_to action: :notexist
    end
  end
end
