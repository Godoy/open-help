class PagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to repos_path
    end
  end
end
