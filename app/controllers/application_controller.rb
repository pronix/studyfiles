class ApplicationController < ActionController::Base
  protect_from_forgery

  def redirect_to_back(default = root_url)
    if !request.env["HTTP_REFERER"].blank? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back
    else
      redirect_to default
    end
  end
   
end
