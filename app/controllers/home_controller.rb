class HomeController < ApplicationController
	  before_action :authenticate_user!

	def index
		celebs = Followmapping.where(follower_id: current_user.id).pluck(:celeb_id)
		celebs[celebs.length] = current_user.id
		@posts=Post.where(user_id: celebs)
		@posts.order(:created_at, :desc)
	end

	def alluser
		@users = User.all
	end
end
