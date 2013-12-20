require 'spec_helper'

describe SubLink do

  describe "associations" do
    it { should belong_to(:sub) }
    it { should belong_to(:link) }
  end

end
