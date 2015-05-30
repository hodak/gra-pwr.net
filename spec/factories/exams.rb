# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exam do
    name "MyString"

    factory :exam_with_questions do
      questions { FactoryGirl.create_list(:question_with_answers, 3) }
    end
  end
end
