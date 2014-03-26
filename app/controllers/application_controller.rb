class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from "Exception", with: :issue

  private

    def issue exception
      case "#{exception}"
      when "Section Name Error"
        redirect_to root_path, notice: "Duplicate section names are not permitted."
      when "Key Name Error"
        redirect_to root_path, notice: "Duplicate key names for each section are not permitted."
      when "File Format Error"
        redirect_to root_path, notice: "Please upload a properly formatted text file."
      when "File Type Error"
        redirect_to root_path, notice: "Please upload a .txt or .rtf file."
      when "File Existence Error"
        redirect_to root_path, notice: "Please add a file to upload."
      else
        redirect_to root_path, notice: "There was a problem. Please try again."
      end
    end

end
