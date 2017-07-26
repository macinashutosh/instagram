class ProfileController < ApplicationController
		  before_action :authenticate_user!
		  
		  def index
          	@user=current_user
          	posts = Post.where(user_id: current_user.id).pluck(:id)
      		@notifications = Like.where(post_id: posts)
		  end
		  def popup
		  		
		  end
		  
end
