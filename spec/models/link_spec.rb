# == Schema Information
#
# Table name: links
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  url        :string(255)      not null
#  body       :string(255)
#  poster_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Link do
  subject(:l) { FactoryGirl.build(:link) }

  describe "associations" do
    it { should have_many(:sub_links) }
    it { should have_many(:subs) }
    it { should belong_to(:poster) }
    it { should have_many(:comments) }
  end

  describe "#comments_by_parent_id" do
    context "when there are no comments" do
      it "should return an empty hash" do
        expect(l.comments_by_parent_id).to eq({})
      end
    end

    context "when there are only top-level comments without parent" do
      before(:each) do
        10.times do
          l.comments << FactoryGirl.build(:comment)
        end
        @comments = l.comments_by_parent_id
      end

      it "should return a hash with nil that points to array of 10 elements" do
        expect(@comments[nil]).to have(10).items
      end

      it "should return a hash with nil that points to an array of comments" do
        expect(@comments[nil].all? { |el| el.is_a?(Comment) }).to be_true
      end
    end

    context "when there are nested comments" do
      before(:each) do
        possible_parents = [nil]
        10.times do |i|
          parent = possible_parents.sample
          possible_parents << i
          l.comments << FactoryGirl.build(:comment, :parent_id => parent)
        end
        @comments = l.comments_by_parent_id
      end

      it "should have ten comments" do
        expect(@comments.values.flatten).to have(10).items
      end

      it "should only have comments" do
        expect(@comments.values.flatten
              .all? { |el| el.is_a?(Comment) }).to be_true
      end

      it "should have all comments keyed to their parent_id" do
        correct_keys = @comments.all? do |key, value|
          value.all? { |comment| comment.parent_id == key }
        end
        expect(correct_keys).to be_true
      end
    end
  end
end
