class HomeController < ApplicationController
	  before_action :authenticate_user!

	def index
		celebs = Followmapping.where(follower_id: current_user.id).pluck(:celeb_id)
		celebs[celebs.length] = current_user.id
		@posts=Post.where(user_id: celebs)
    @posts.order! 'created_at DESC'
  end

	def alluser
		@users = User.all
	end

	def follow
  	celeb_id = params[:celeb_id]
  	if current_user.can_follow celeb_id
  		Followmapping.create(:celeb_id => celeb_id, :follower_id => current_user.id)
  	else
  	end
  	 return redirect_to '/home/alluser'
  end

  def un_follow
  	celeb_id = params[:celeb_id]
  	if current_user.can_un_follow celeb_id
  		Followmapping.where(:celeb_id => celeb_id, :follower_id => current_user.id).first.destroy
  	else
  	end

     return redirect_to '/home/alluser'
  end

end
