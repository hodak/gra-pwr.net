class UserAnswer < ActiveRecord::Base
  belongs_to :user_exam
  has_one :user, through: :user_exam
  belongs_to :question
end
