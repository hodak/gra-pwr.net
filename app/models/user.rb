class User < ActiveRecord::Base
  has_many :user_exams
  has_many :exams, through: :user_exams
  has_many :user_answers
  has_many :answers, through: :user_answers
end
