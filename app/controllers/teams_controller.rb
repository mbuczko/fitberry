class TeamsController < ApplicationController
  before_filter :check_access, :except => [:show, :users]

  def users
    @activities = Activity.teamed(params[:id])

    respond_to do |format|
      format.json
    end
  end

end
