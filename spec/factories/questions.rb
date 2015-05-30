# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    exam { FactoryGirl.create(:exam) }
    text "MyText"

    factory :question_with_answers do
      answers { FactoryGirl.create_list(:answer, 3) }
    end
  end
end
