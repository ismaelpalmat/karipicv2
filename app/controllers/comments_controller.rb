class CommentsController < ApplicationController
# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id]) # Encuentra la foto relacionada
    @comment = @photo.comments.build(comment_params) # Construye el comentario asociado a la foto

    if @comment.save
      redirect_to @photo, notice: 'Comment was successfully added.' # Redirige a la foto
    else
      flash[:alert] = 'Comment could not be saved.'
      redirect_to @photo
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content) # Asegúrate de permitir el campo content
  end
end

end
