class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(params[:prototype_id])
    else
      @prototype = Prototype.find(params[:prototype_id])
      @comments = @prototype.comments.includes(:user)
      render '/prototypes/show'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
    # , prototype_id: params[:id]もmerge必要
  end
end
