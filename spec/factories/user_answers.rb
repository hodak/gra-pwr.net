# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_answer do
    user_exam { FactoryGirl.create(:exam) }
    answer { FactoryGirl.create(:answer) }
  end
end
