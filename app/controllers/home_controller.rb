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
    @can_follow = false
    @can_unfollow = false
    @user = celeb_id
  	if current_user.can_follow celeb_id
  		Followmapping.create(:celeb_id => celeb_id, :follower_id => current_user.id)
      @can_follow = true
  	elsif current_user.can_un_follow celeb_id
      @can_unfollow = true
      Followmapping.where(:celeb_id => celeb_id, :follower_id => current_user.id).first.destroy
  	end
     respond_to do |format|
      format.html { redirect_to '/home/alluser' }
      format.js {}
      format.json{}
      end
  	 # return redirect_to '/home/alluser'
  end

  def notification
    posts = Post.where(user_id: current_user.id).pluck(:id)
    @notifications = Like.where(post_id: posts)
    @notifications += Comment.where(post_id: posts)
    @notifications += Followmapping.where(celeb_id: current_user.id)
    @notifications.sort_by! &:created_at
    @notifications.reverse!
    notification = Notification.where(user_id: current_user.id).first
    if notification.nil?
        Notification.create(user_id: current_user.id)
    else
        if notification.created_at < @notifications.first.created_at
              notification.destroy  
        else  
              notification.destroy  
              Notification.create(user_id: current_user.id)
        end
    end
    respond_to do |format|
      format.html{redirect_to '/home/index'}
      format.js{}
    end
  end

 
  # def un_follow
  # 	celeb_id = params[:celeb_id]
  #    @can_follow = false
  #   @user = celeb_id
  # 	if current_user.can_un_follow celeb_id
  #     @can_follow = true
  # 		Followmapping.where(:celeb_id => celeb_id, :follower_id => current_user.id).first.destroy
  # 	else
  # 	end
  #     respond_to do |format|
  #     format.html { redirect_to '/home/alluser' }
  #     format.js {}
  #     format.json{}
  #     end
  #    # return redirect_to '/home/alluser'
  # end

end
