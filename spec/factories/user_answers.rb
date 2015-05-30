# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_answer do
    user_exam { FactoryGirl.create(:user_exam) }
    question { FactoryGirl.create(:question_with_answers) }
    answers { [] }
  end
end
