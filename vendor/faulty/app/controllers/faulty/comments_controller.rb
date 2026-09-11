module Faulty
  class CommentsController < ApplicationController
    before_action :set_error

    def create
      Rails.logger.info("params: #{params.inspect}")
      @comment = @error.comments.build(comment_params)
      @comment.author = Faulty.current_faulty_user.call(self)

      if @comment.save
        redirect_to error_path(@error), notice: "Comment added successfully."
      else
        redirect_to error_path(@error), alert: "Failed to add comment."
      end
    end

    private

    def set_error
      @error = Faulty::Error.find(params[:error_id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
  end
end
