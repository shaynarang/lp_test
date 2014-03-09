class UploadsController < ApplicationController
  def index
    @uploads = Upload.all
  end

  def show
    @upload = Upload.find(params[:id])
  end

  def new
  end

  def create
    if params[:file].blank?
      redirect_to root_path, notice: "Please add a file to upload."
    elsif !params[:file].original_filename[/.(\.txt|\.rtf)$/i]
      redirect_to root_path, notice: "Please upload a .txt or .rtf file."
    elsif !params[:file].read.include?("["&&"]"&&":")
      redirect_to root_path, notice: "Please upload a properly formatted text file."
    else
      @upload = Upload.new
      @upload.file = params[:file]
      @upload.save ? (redirect_to upload_path(@upload)) : (redirect_to root_path, notice: "Something went wrong.")
    end
  end

  def destroy
    @upload = Upload.find(params[:id])
    redirect_to root_path
  end

end
