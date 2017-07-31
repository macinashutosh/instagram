class ProfileController < ApplicationController
		  before_action :authenticate_user!
		  
		  def index
          	@user=current_user
          	@post=Post.new
		  end
		  def popup
		  		
		  end
		  
		  
end
