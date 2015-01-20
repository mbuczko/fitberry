class ActivitiesController < ApplicationController

  # GET /activities
  def index

    # provided by path /history/:id
    id = params[:chid]

    # find the challange either by given id (if history was requested) or by active status
    @challange = (id ? Challange.find(id) : Challange.find_by_active(true)) || Challange.new

    @teams = Team.challanged(@challange)
    @blogs = Blog.recent(@challange)

    @activities = Activity.challanged(@challange).limit(5)
    @milestones = @challange.milestones

    @blog = @blogs.first

    if @blog
      @blog.has_next = false
      @blog.has_prev = @blogs.size > 1
    end

    if @challange.converter
      @challange.money = (@challange.converter * @teams.reduce(0) {|result, obj| result + obj.distance }).round(2)
    end

    respond_to do |format|
      format.html
    end
  end

  def highscore
    challange = Challange.find(params[:chid])
    @activities = Activity.challanged(challange).limit(10)

    respond_to do |format|
      format.js # highscore.js.erb
    end
  end
end
