class UserExam < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam
  has_many :user_answers

  scope :for_user, -> (user) do
    where(user: user)
      .includes({ exam: { questions: :answers } })
  end

  def repeat
    read_attribute(:repeat) || 3
  end

  def repeat_wrong
    read_attribute(:repeat_wrong) || 3
  end
end
