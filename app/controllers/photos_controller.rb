class PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_photo, only: %i[ show edit update destroy ]

  # GET /photos or /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1 or /photos/1.json
  def show
    @photos = Photo.all # Esto te da acceso a todas las fotos
  end
  
  

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos or /photos.json
  class PhotosController < ApplicationController
    def create
      @photo = Photo.new(photo_params)
      if @photo.save
        redirect_to @photo, notice: 'Photo was successfully created.'
      else
        render :new
      end

      if current_user.nil?
        # Puedes manejar el caso si no hay un usuario autenticado
        redirect_to new_user_session_path, alert: 'You must be signed in to upload a photo.'
        return
      end
    
      @photo = current_user.photos.new(photo_params)
    
      if @photo.save
        redirect_to @photo, notice: 'Photo was successfully created.'
      else
        Rails.logger.debug @photo.errors.full_messages  # Para ver los errores
        render :new
      end
    
  
    private
  
    def photo_params
      params.require(:photo).permit(:image_url)
    end
  end
  
  end

  # PATCH/PUT /photos/1 or /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: "Photo was successfully updated." }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1 or /photos/1.json
  def destroy
    @photo.destroy!

    respond_to do |format|
      format.html { redirect_to photos_path, status: :see_other, notice: "Photo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def photo_params
      params.require(:photo).permit(:caption, :user_id, :image)
    end
end
