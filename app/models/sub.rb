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

class Sub < ActiveRecord::Base
  attr_accessible :moderator_id, :name
  validates :name, :moderator, :presence => true

  belongs_to :moderator, :class_name => "User"
  has_many :sub_links, :dependent => :destroy
  has_many :links, :through => :sub_links, :inverse_of => :subs
end
