class Followmapping < ActiveRecord::Base
	validates_uniqueness_of :celeb_id, scope: :follower_id
end
