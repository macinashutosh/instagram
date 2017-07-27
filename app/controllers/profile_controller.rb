class ProfileController < ApplicationController
		  before_action :authenticate_user!
		  
		  def index
          	@user=current_user
          	check_notification
		  end
		  def popup
		  		
		  end
		  
		  def check_notification
      		posts = Post.where(user_id: current_user.id).pluck(:id)
       		notifications = Like.where(post_id: posts)
      		notifications += Comment.where(post_id: posts)
      		notifications += Followmapping.where(celeb_id: current_user.id)
      		notifications.sort_by! &:created_at
      		notifications.reverse!
    		notification = Notification.where(user_id: current_user.id).first
    		if notification.nil?
        	Notification.create(user_id: current_user.id)
    		else
        		if notification.created_at < notifications.first.created_at
              		notification.destroy  
        		else  
              		notification.destroy  
              		Notification.create(user_id: current_user.id)
        		end
    		end
  			end
end
