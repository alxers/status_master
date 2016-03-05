class Users::OmniauthCallbacksController < ApplicationController
  skip_before_filter :authenticate_user!

  def slack
    @user = User.find_for_slack_oauth request.env["omniauth.auth"], params
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      flash[:notice] = "authentication error"
      redirect_to root_path
    end
  end

  # def failure
  #   binding.pry
  # end
end
