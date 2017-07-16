class User < ActiveRecord::Base
	has_many :likes
	has_many :posts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


         def follow_relation user_id
  			return UserRelations::SELF if id == user_id
  			if FollowMapping.where(:celeb_id => user_id, :follower_id => id).length > 0
  				return UserRelations::FOLLOWED
  			else
  				return UserRelations::NOTFOLLOWED
  			end
  		end

  		def can_follow user_id
  			return follow_relation(user_id) == UserRelations::NOTFOLLOWED
  		end

  		def can_un_follow user_id
    		return follow_relation(user_id) == UserRelations::FOLLOWED
  		end

  		def followee_ids
  			FollowMapping.where(follower_id: id).pluck(:celeb_id)
  		end


  		class UserRelations
  			SELF = 0
  			FOLLOWED = 1
  			NOTFOLLOWED = 2
  		end
end
