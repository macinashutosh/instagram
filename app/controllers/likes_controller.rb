class LikesController < ApplicationController
		def like
	post_id = params[:post_id]
	like = Like.where(post_id: post_id, user_id:current_user.id).first
	unless like
		like = Like.new
		like.post_id = post_id
		like.user_id = current_user.id
		like.save
	else
		like.destroy
	end

	return redirect_to '/posts'

end
end
