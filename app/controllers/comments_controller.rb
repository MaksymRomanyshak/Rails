class CommentsController < ApplicationController
    before_action :set_movie, only: :create
  
    def create
      @commentable = @movie
      @comment = @commentable.comments.build(comment_params)
      @comment.user = current_user
  
      if @comment.save
        redirect_to @movie, notice: "Comment created successfully."
      else
        redirect_to @movie, alert: "Failed to create comment."
        flash[:error] = @comment.errors.full_messages.join(', ')
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  
    def set_movie
      @movie = Movie.find(params[:movie_id])
    end
  end
  