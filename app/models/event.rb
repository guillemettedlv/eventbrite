class Event < ApplicationRecord
  has_many :attendances
	has_many :users, through: :attendances
  belongs_to :organizer, class_name: "User"
  
  def end_date
		return start_date + (duration*60)
  end
  
  def is_user_attending?(user)
		if self.attendances.where(user_id: user.id).count > 0
			puts "The user is attending"
			# if the user is attending we return true
			return true
		else
			puts "The user is not attending"
			return false
		end
  end
end
