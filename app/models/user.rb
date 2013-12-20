# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :username, :password
  validates :username, :password_digest, :session_token, :presence => true
  validates :password, :length => { :minimum => 6 }, :on => :create
  attr_reader :password

  before_validation :reset_session_token, :on => :create

  has_many :subs, :foreign_key => :moderator_id
  has_many :links, :foreign_key => :poster_id
  has_many :comments, :foreign_key => :author_id

  def self.find_by_credentials(params)
    user = User.find_by_username(params[:username])
    return user if user && user.is_password?(params[:password])
    nil
  end

  def is_password?(pt)
    BCrypt::Password.new(self.password_digest).is_password?(pt)
  end

  def password=(pt)
    @password = pt
    self.password_digest = BCrypt::Password.create(pt)
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    reset_session_token
    self.save
  end
end
