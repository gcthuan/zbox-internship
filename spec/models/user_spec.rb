require 'spec_helper'

describe User do
  it "is valid with a full name, email, and password" do
	user = User.new(
		username: 'Giang Chi Thuan',
		email: 'gcthuan@apcs.vn',
		password: '12345678',
		password_confirmation: '12345678')
	expect(user).to be_valid
  end
  it "is invalid without a fullname" do
	expect(User.new(username: nil)).to have(1).errors_on(:username)
  end
  it "is invalid without an email" do
	expect(User.new(email: nil)).to have(1).errors_on(:email)
  end
  it "is invalid with a duplicate email address" do
  	User.create(
  		username: 'Giang Chi Thuan',
  		email: 'gcthuan@example.com',
  		password: '12345678',
  		password_confirmation: '12345678')
	user = User.new(
		username: 'Giang Chi Thuan',
		email: 'gcthuan@example.com',
		password: '12345678',
		password_confirmation: '12345678')
	expect(user).to have(1).errors_on(:email)
  end
  it "has a valid factory" do
	expect(FactoryGirl.build(:user)).to be_valid
  end
end
