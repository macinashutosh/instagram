class CommentsController < ApplicationController
	def comment 
    postid=params[:postid]
    @postid=postid
    content=params[:content]
    new_comment=Comment.new
    new_comment.user_id=current_user.id
    new_comment.post_id=postid
    new_comment.content=content
    new_comment.save
    @comment=new_comment
    respond_to do |format|
    format.html{redirect_to '/home/index'}
    format.js {}
end
	end
end
