class AdminController < ApplicationController

  before_filter :check_access

  def index
    @users = User.all
    respond_to do |format|
      format.html # _index.html.erb
    end

  end
end
