class ProfilesController < ApplicationController
  skip_before_action :ensure_profile_completed

  def edit
  end

  def update
    if current_user.update profile_params
      redirect_to profile_path, notice: "Your profile has been updated. ;)"
    else
      redirect_to profile_path, notice: "Your profile couldn't be updated :'("
    end
  end

  private
    def profile_params
      params.permit(:code_sample)
    end
end
