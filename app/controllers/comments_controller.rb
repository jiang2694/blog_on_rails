class CommentsController < ApplicationController
  before_action :autheticated_user!, only: [:new]
  before_action :find_comment, only: [:destroy]
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    if @comment.save
      redirect_to post_path(@post), notice: "comment created!"
      # if saved successfully then redirect to the show page of the question
      # otherwise still go to this show page but using render
      # the difference between redirect and render
      # redirect is sending a get request '/questions/:id'
      # render is rendering the page
    else
      # we want to stay on this page
      @comments = @post.comments.order(created_at: :desc)
      # '/questions/show' is not the action
      # it's the page /questions/show.html.erb
      render '/posts/show', status: 303
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post), notice: 'Comment Deleted'
  end

  private

  

  def comment_params
    params.require(:comment).permit(:title, :body)
  end

end
