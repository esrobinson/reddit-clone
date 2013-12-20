require 'spec_helper'

describe Comment do
  describe "associations" do
    it { should belong_to(:link) }
    it { should belong_to(:author) }
    it { should belong_to(:parent) }
    it { should have_many(:children) }
  end


end
