class CommentsController < ApplicationController
	def comment 
    postid=params[:postid]
    content=params[:content]
    new_comment=Comment.new
    new_comment.user_id=current_user.id
    new_comment.post_id=postid
    new_comment.content=content
    new_comment.save
    return redirect_to '/posts'
	end
end
