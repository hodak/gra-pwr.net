# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_exam do
    user { FactoryGirl.create(:user) }
    exam { FactoryGirl.create(:exam) }
    repeat 1
    repeat_wrong 1

    factory :user_exam_with_questions do
      exam { FactoryGirl.create(:exam_with_questions) }
    end
  end
end
