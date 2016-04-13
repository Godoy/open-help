class PagesController < ApplicationController
  def home
    if user_signed_in?
      @repositories = Octokit.repositories current_user.nickname
    end
  end
end
