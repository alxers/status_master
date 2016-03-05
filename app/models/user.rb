class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable



  def self.find_for_slack_oauth(access_token, params)
    url = 'https://slack.com/api/oauth.access'
    resp =  HTTParty.get(url, query: {client_id: Rails.application.secrets.slack['app_id'], client_secret: Rails.application.secrets.slack['app_secret'], code: params['code']})

    binding.pry()
    if user = User.where(:uid => access_token.info.user_id).first
      user
    else
      User.create!(:uid => access_token.info.user_id, :email =>  access_token.info.email, :password => Devise.friendly_token[0,20])
    end
  end
end
