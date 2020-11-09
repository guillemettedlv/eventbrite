class Event < ApplicationRecord
  has_many :attendances
	has_many :users, through: :attendances
  belongs_to :organizer, class_name: "User"

  has_one_attached :avatar
  validate :has_a_picture?

  validates :start_date, presence: true 
	validate :is_start_date_past?

	validates :duration, presence: true
  validate :is_duration_correct?
  
  validates :title, presence: true, length: {minimum: 5, maximum: 140}
	validates :description, presence: true, length: {minimum: 20, maximum: 1000}

	validates :price, presence: true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 1000}
  validates :location, presence: true
  
  	# To check if the date is correct
	def is_start_date_past?
		if start_date < Time.now
			errors.add(:start_date, "can't be in the past")
		end
	end

	# To check if the duration is correct
	def is_duration_correct?
		if duration <= 0 || (duration % 5) != 0 
			errors.add(:duration, "must be positive and a multiple of 5, easy !")
		end			
	end

  def has_a_picture?
		if self.avatar.attached? == false
			errors.add(:avatar, "You must upload an event picture")
		end
	end

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
