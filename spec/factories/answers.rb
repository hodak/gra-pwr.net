# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    question { FactoryGirl.create(:question) }
    text "MyText"
    correct { [true, false].sample }
  end
end
