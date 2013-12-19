require 'spec_helper'

describe Sub do
  describe "associations" do
    it { should belong_to(:moderator) }
  end

  describe "name" do
    it "should be mass assignable" do
      expect{ Sub.new(:name => "funny") }.not_to raise_error
    end
  end

  describe "moderator_id" do
    it "should be mass assignable" do
      expect{ Sub.new(:moderator_id => 1) }.not_to raise_error
    end
  end
end
