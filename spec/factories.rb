FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "password"
    password_confirmation "password"
    activated true


    factory :admin do
      admin true
      activated true
    end
  end


  factory :micropost do
    content "Lorem ipsum"
    user
  end
end