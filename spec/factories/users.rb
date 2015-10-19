include RandomData

FactoryGirl.define do 
  pw = RandomData.random_sentence
  #3 name of the factory user
  factory :user do 
    name RandomData.random_name
    #4 each user will have uniq email addresses with 'sequence'.
    sequence(:email){|n| "user#{n}@factory.com" }
    password pw
    password_confirmation pw
    role :member
  end 
end 