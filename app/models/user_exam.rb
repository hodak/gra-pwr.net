class UserExam < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam
  has_many :user_answers

  validates_uniqueness_of :exam_id, scope: :user_id

  scope :for_user, -> (user) do
    where(user: user)
      .includes({ exam: { questions: :answers } })
  end
end
