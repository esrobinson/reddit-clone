class Comment < ActiveRecord::Base
  attr_accessible :body

  validates :author, :body, :link, :presence => true

  belongs_to :link
  belongs_to :author, :class_name => "User"
  belongs_to :parent, :class_name => "Comment"
  has_many :children, :class_name => "Comment", :foreign_key => :parent_id

end
