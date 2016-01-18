FactoryGirl.define do
  factory :user do
    email 'test@drdealaday.org'
    password "password"
    password_confirmation "password"
  end
end
