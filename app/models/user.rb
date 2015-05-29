class User < ActiveRecord::Base
  has_many :user_tests
  has_many :tests, through: :user_tests
  has_many :user_answers
  has_many :answers, through: :user_answers
end
