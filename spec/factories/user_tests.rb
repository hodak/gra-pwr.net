# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_test do
    user_id 1
    test_id 1
    repeat 1
    repeat_wrong 1
  end
end
