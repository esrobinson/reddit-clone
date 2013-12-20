class SubLink < ActiveRecord::Base
  attr_accessible :link_id, :sub_id
  validates :link, :sub, :presence => true

  belongs_to :sub
  belongs_to :link
end
