# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_exam do
    user_id 1
    exam_id 1
    repeat 1
    repeat_wrong 1
  end
end
