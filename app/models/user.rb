class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable



  def self.find_for_slack_oauth(access_token)
    binding.pry()
    if user = User.where(:uid => access_token.info.user_id).first
      user
    else
      User.create!(:uid => access_token.info.user_id, :email =>  access_token.info.email, :password => Devise.friendly_token[0,20])
    end
  end
end
