class Ckeditor::AttachmentFilesController < Ckeditor::ApplicationController

  def index
    authorize! :index,  Ckeditor::AttachmentFile
    @attachments = Ckeditor.attachment_file_model.find_all(ckeditor_attachment_files_scope(:assetable_id => current_user.id))
    respond_with(@attachments)
  end
  
  def create
    @attachment = Ckeditor::AttachmentFile.new
    authorize! :create,  @attachment
	  respond_with_asset(@attachment)
  end
  
  def destroy
    @attachment.destroy
    authorize! :destroy,  @attachment
    respond_with(@attachment, :location => attachment_files_path)
  end
  
  protected
  
    def find_asset
      @attachment = Ckeditor.attachment_file_model.get!(params[:id])
    end

    def authorize_resource
      model = (@attachment || Ckeditor::AttachmentFile)
      @authorization_adapter.try(:authorize, params[:action], model)
    end
end
