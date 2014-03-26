class UploadsController < ApplicationController
  def index
    @uploads = Upload.all
  end

  def show
    @upload = Upload.find(params[:id])
  end

  def edit
    @upload = Upload.find(params[:id])
  end

  def update
    @upload = Upload.find(params[:id])
    @upload.update(upload_params)
    @upload.save ? (redirect_to upload_path(@upload)) : (redirect_to upload_path(@upload), notice: "Something went wrong. Please try again.")
  end

  def new
  end

  def create
    raise "File Existence Error" if params[:file].blank?
    raise "File Type Error" if !params[:file].original_filename[/.(\.txt|\.rtf)$/i]
    raise "File Format Error" if !params[:file].read.include?("["&&"]"&&":")
    @upload = Upload.new
    @upload.file = params[:file]
    @upload.save ? (redirect_to upload_path(@upload)) : (raise "General Error")
  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.delete
    redirect_to uploads_path
  end

  def download
    @upload = Upload.find(params[:id])
    upload_string = render_to_string(partial: "upload")
    send_data(Upload.format_for_download(upload_string), filename: "#{@upload.file_name_without_ext}.txt", type: "text/plain")
  end

  private

    def upload_params
      params.require(:upload).permit(:id, :file_name, :sections_attributes => [ :id, :title, :keys_attributes => [ :id, :title, :values_attributes => [ :id, :content] ] ])
    end

end
