class PagesController < ApplicationController
  
  def home
    redirect_to movies_path
  end

end