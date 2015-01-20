class CommentsController < ApplicationController
  before_filter :authenticate_user!, :except => :show

  def show
    @comments = Comment.current(params[:id])
  end

  def new
    article = Blog.find(params[:id])
    @comment = Comment.new(:blog_id => article.id)
  end

  def create
    @comment = Comment.new({:body => params[:comment][:body],
                            :blog_id => params[:comment][:blog_id],
                            :user_id => current_user.id})

    if params[:commit] == 'Preview'
      @comment.htmlize
      render :action => 'preview'
    else
      @comment.save
      @comments = Comment.current(@comment.blog_id)
      render :action => 'show'
    end
  end
end