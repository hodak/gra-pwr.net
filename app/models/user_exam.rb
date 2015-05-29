class UserExam < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam

  scope :for_user, -> (user) { where(user: user).includes(:exam) }
end
