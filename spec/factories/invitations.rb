# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    association :user, :factory => :user, :password_reset_token => "something", :password_reset_sent_at => 1.hour.ago
    book

    factory :invalid_invitation do
      association :user, :factory => :user, :password_reset_token => "something", :password_reset_sent_at => 5.hours.ago
    end
  end
end
