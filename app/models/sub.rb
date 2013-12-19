class Sub < ActiveRecord::Base
  attr_accessible :moderator_id, :name
  validates :name, :moderator, :presence => true

  belongs_to :moderator, :class_name => "User"
end
