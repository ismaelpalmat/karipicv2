class CommentsController < ApplicationController
# app/controllers/comments_controller.rb
  def create
    @photo = Photo.find(params[:photo_id])
    @comment = @photo.comments.build(comment_params)
    @comment.user = current_user # Cambia esto según cómo manejes usuarios

    if @comment.save
      redirect_to @photo, notice: 'Comment added successfully.'
    else
      redirect_to @photo, alert: 'Failed to add comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
