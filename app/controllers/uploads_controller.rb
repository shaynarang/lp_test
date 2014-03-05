class UploadsController < ApplicationController
  def index
  end

  def import
    if params[:file].blank?
      redirect_to root_url, notice: "Please add a file to import."
    elsif Upload.import(params[:file])
      redirect_to root_url, notice: "File imported."
    else
      redirect_to root_url, notice: "Something went wrong. Please try again."
    end
  end

end
