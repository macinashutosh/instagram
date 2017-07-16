class LikesController < ApplicationController
		def like
	tweet_id = params[:tweet_id]
	like = Like.where(tweet_id: tweet_id, user_id: session[:user_id]).first
	unless like
		like = Like.new
		like.tweet_id = tweet_id
		like.user_id = session[:user_id]
		like.save
	else
		like.destroy
	end

	return redirect_to '/posts'

end
end
