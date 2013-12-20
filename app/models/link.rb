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

class Link < ActiveRecord::Base
  attr_accessible :body, :title, :url, :sub_ids
  validates :title, :url, :poster, :presence => true

  has_many :sub_links, :dependent => :destroy
  has_many :subs, :through => :sub_links, :inverse_of => :links
  belongs_to :poster, :class_name => "User"
  has_many :comments, :dependent => :destroy

  def comments_by_parent_id
    comments = self.comments

    {}.tap do |comment_hash|
      comments.each do |comment|
        comment_hash[comment.parent_id] ||= []
        comment_hash[comment.parent_id] << comment
      end
    end
  end
end
