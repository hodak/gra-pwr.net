class Exam < ActiveRecord::Base
  has_many :questions
  has_many :user_exams
  has_many :users, through: :user_exams
end
