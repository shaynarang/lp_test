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
      redirect_to root_path, notice: "Please add a file to import."
    else
      @upload = Upload.new
      @upload.file = params[:file]
      if @upload.save
        redirect_to upload_path(@upload), notice: "File imported."
      else
        redirect_to root_path, notice: "Some went wrong. Please try again."
      end
    end
  end

  def destroy
    @upload = Upload.find(params[:id])
    redirect_to root_path
  end

end
