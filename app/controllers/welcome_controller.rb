class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.enquete
        redirect_to home_index_path
      else
        redirect_to new_enquete_path
      end

    end
  end
end
