class MilestonesController < ApplicationController
  before_filter :check_access, :except => :show

  # GET /milestones/new
  def new
    @challange = Challange.find(params[:challange_id])
    @milestone = Milestone.new

    respond_to do |format|
      format.js
    end
  end

  # GET /milestones/1/edit
  def edit
    @milestone = Milestone.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  # POST /milestones
  def create
    @challange = Challange.find(params[:milestone][:challange_id])
    @milestone = Milestone.new(params[:milestone])
    @milestone.number = @challange.milestones.count

    respond_to do |format|
      if @milestone.save
        format.js { render action: "index" }
      else
        format.js { render action: "new" }
      end
    end
  end

  # PUT /milestones/1
  def update
    @milestone = Milestone.find(params[:id])
    @challange = @milestone.challange

    respond_to do |format|
      if @milestone.update_attributes(params[:milestone])
        format.js { render action: "index" }
      else
        format.js { render action: "edit" }
      end
    end
  end

  # DELETE /milestones/1
  def destroy
    @milestone = Milestone.find(params[:id])
    @milestone.destroy

    render :nothing => true
  end
end
