class User < ActiveRecord::Base
  acts_as_authentic
  attr_accessible :email, :login, :password, :password_confirmation
end
