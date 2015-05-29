class Test < ActiveRecord::Base
  has_many :questions
  has_many :user_tests
  has_many :users, through: :user_tests
end
