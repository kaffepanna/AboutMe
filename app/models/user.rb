class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field :email
  end
  attr_accessible :email, :login, :password, :password_confirmation
end
