class User < ActiveRecord::Base
	has_many :likes
	has_many :posts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  has_attached_file :avatar, styles: { medium: "160x160#", thumb: "40x40#" },
  :default_url => ":style/missing_avatar.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         validates :fullname , length: {minimum: 1}
         validates :username , length: {minimum: 1}, uniqueness: true;

 
         def follow_relation user_id
  			return UserRelations::SELF if id == user_id
  			if Followmapping.where(:celeb_id => user_id, :follower_id => id).length > 0
  				return UserRelations::FOLLOWED
  			else
  				return UserRelations::NOTFOLLOWED
  			end
  		end

  		def can_follow user_id
          if self.id == user_id
            return false
          end
  			return follow_relation(user_id) == UserRelations::NOTFOLLOWED
  		end

  		def can_un_follow user_id
    		if self.id == user_id
            return false
          end
        return follow_relation(user_id) == UserRelations::FOLLOWED
  		end

      def follow_button user_id
          if self.can_follow(user_id)
              return "follow.png"
          elsif self.can_un_follow(user_id)
                return "following.png"
          else
                return "follow.png"
          end

      end

  		def followee_ids
  			Followmapping.where(follower_id: id).pluck(:celeb_id)
  		end

      def has_notifications
          notification = Notification.where(user_id: self.id).first
          if (notification.nil?)
              return true
          else
              if notification.created_at < self.updated_at
                return true
              else
                return false
              end
          end
      end

  		class UserRelations
  			SELF = 0
  			FOLLOWED = 1
  			NOTFOLLOWED = 2
  		end
end
