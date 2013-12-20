# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe Sub do
  describe "associations" do
    it { should belong_to(:moderator) }
    it { should have_many(:sub_links) }
    it { should have_many(:links) }
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
