class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :user_answers
  has_many :users, through: :user_answers
end
