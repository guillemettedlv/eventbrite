class Attendance < ApplicationRecord
  after_create :attendance_send

  belongs_to :user
  belongs_to :event
  
  def attendance_send
		AttendanceMailer.participation_email(self.user, self.event.organizer, self.event).deliver_now
	end
end
