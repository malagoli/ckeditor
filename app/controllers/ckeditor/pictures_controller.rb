class Ckeditor::PicturesController < Ckeditor::ApplicationController

  def index
    authorize! :index,  Ckeditor::Picture
    @pictures = Ckeditor.picture_model.find_all( ckeditor_pictures_scope(:assetable_id => current_user.id) )
    respond_with(@pictures)

  end

  def create
    @picture = Ckeditor::Picture.new
    authorize! :create, @picture
    respond_with_asset(@picture)
  end

  def destroy
    @picture.destroy

    authorize! :destroy, @picture
    respond_with(@picture, :location => pictures_path)
  end

  protected

  def find_asset
    @picture = Ckeditor.picture_model.get!(params[:id])
  end

  def authorize_resource
    model = (@picture || Ckeditor::Picture)
    @authorization_adapter.try(:authorize, params[:action], model)
  end
end
