class UsersController < ApplicationController
  def show
    set_user(params[:id])
  end

  private
  def set_user(userId)
    if User.exists?(id: userId)
      @user = User.find(userId)
      @prototypes = @user.prototypes.order("id DESC")
      return true
    else
      render '/notexist'
      # redirect_to action: :notexist
      return false
    end
  end
end
