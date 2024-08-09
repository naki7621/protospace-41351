class CommentsController < ApplicationController
  before_action :set_prototype, only: [:create]

  def create
    @comment = @prototype.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to prototype_path(@prototype)
    else
      @comments = @prototype.comments
      render "prototypes/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)  # :text ではなく :content であることを確認
  end

  def set_prototype
    @prototype = Prototype.find(params[:prototype_id])
  end
end