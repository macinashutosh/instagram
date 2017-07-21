class LikesController < ApplicationController
		def like
			@value=params[:value]
			puts @value
	post_id = params[:post_id]
	@post=Post.find(post_id)
	@postid=@post.id
	like = Like.where(post_id: post_id, user_id:current_user.id).first
	unless like
		like = Like.new
		like.post_id = post_id
		like.user_id = current_user.id
		like.save
	else
		like.destroy
	end
	respond_to do |format|
    format.html{ redirect_to '/home/index'}
	format.js{}
end
end
end
