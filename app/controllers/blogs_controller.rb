class BlogsController < ApplicationController
  before_filter :check_access, :except => :slide

  def publish
    published = Blog.find(params[:id])
    if published && !published.published_at
      published.update_attributes(:published_at => DateTime.now)
    end
    redirect_to admin_blogs_path
  end

  def preview
    @body = RedCloth.new(params[:markup]).to_html.html_safe
    @title = params[:title]
    @image = params[:image]

    render :show, :layout => false
  end

  def upload
    blog = Blog.find(params[:id])

    if blog
      blog.update_attribute(:image, params[:file]) if params[:file]
    end
    redirect_to edit_admin_blog_url(blog)
  end

  def slide
    chid, date, direction = params[:chid], params[:date], params[:direction]

    if direction == "next"
      blogs = Blog.where("challange_id=? and published_at>?", chid, date.to_datetime).reorder("published_at ASC").limit(2)
      @blog = blogs.first
      @blog.has_next = (blogs.length == 2)
      @blog.has_prev = true
    else
      blogs = Blog.where("challange_id=? and published_at<?", chid, date.to_datetime).limit(2)
      @blog = blogs.first
      @blog.has_next = true
      @blog.has_prev = blogs.length == 2
    end

    render :partial => "activities/blognote"
  end
end

