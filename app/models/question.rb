class Question < ActiveRecord::Base
  belongs_to :exam
  has_many :answers, dependent: :destroy
end
