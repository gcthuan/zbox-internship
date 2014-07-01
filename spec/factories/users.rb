# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :user do
  	username {Faker::Name.name}
  	password "12345678"
  	password_confirmation "12345678"
  	email { Faker::Internet.email }
  end
end
