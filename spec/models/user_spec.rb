# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe User do
  subject(:u){ FactoryGirl.create(:user) }

  describe "associations" do
    it { should have_many(:subs) }
    it { should have_many(:links) }
    it { should have_many(:comments) }
  end

  describe "username" do
    it "should be mass assignable" do
      expect{ User.new(:username => "Username") }.not_to raise_error
    end
  end

  describe "password" do
    it "should be mass assignable" do
      expect{ User.new(:password => "Username") }.not_to raise_error
    end

    it "should be readable" do
      expect(FactoryGirl.build(:user, :password => "password").password)
                        .to eq("password")
    end

    it "should be at least 6 characters" do
      expect(FactoryGirl.build(:user, :password => "pass"))
                        .to have(1).error_on(:password)
    end

    it "should not be stored in the database" do
      u
      expect(User.first.password).to be_nil
    end
  end

  describe "password_digest" do
    it "should not be mass assignable" do
      expect{ User.new(:password_digest => "a") }
          .to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "session_token" do
    it "should not be mass assignable" do
      expect{ User.new(:session_token => "test") }
          .to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end

    it "should be set before validation" do
      expect(u).to have(:no).errors_on(:session_token)
    end
  end

  describe "::find_by_credentials" do
    it "should return a User given username and password" do
      expect(User.find_by_credentials({
          :username => u.username, :password => u.password })).to eq(u)
    end

    it "returns nil if credentials are incorrect" do
      expect(User.find_by_credentials({
          :username => u.username, :password => "wrong" })).to be_nil
    end
  end

  describe "#is_password?" do
    it "should confirm the correct password" do
      expect(u.is_password?(u.password)).to be_true
    end

    it "should reject the incorrect password" do
      expect(u.is_password?("blah")).to be_false
    end
  end

  describe "#reset_session_token" do
    it "should change the session_token" do
      old_token = u.session_token
      u.reset_session_token
      expect(u.session_token).not_to eq(old_token)
    end
  end
end
