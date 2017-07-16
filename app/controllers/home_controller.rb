class HomeController < ApplicationController
	def index
		@posts=Post.all
		
	end

	def alluser
		@users = User.all
	end
end
