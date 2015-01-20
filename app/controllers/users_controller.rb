class UsersController < ApplicationController

  def register
    @user = User.new
    respond_to do |format|
      format.html { render :create } # create.html.erb
    end
  end

  # POST /users
  def create
    @user = User.new(session["devise.user_attributes"], :without_protection => true)
    @user.attributes = params[:user]
    @user.is_admin = false

    @user.save

    if @user.valid?
      sign_in_and_redirect @user
    end
  end

  # GET /profile/1
  def profile
    @user = User.find(params[:id])
    respond_to do |format|
      format.html { render :layout => false }
    end
  end
end
