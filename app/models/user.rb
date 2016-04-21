class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github]

  has_many :repos

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.nickname = auth.info.nickname
      user.name = auth.info.name
    end

    user.tap do |user|
      user.image = auth.info.image
      user.location = auth.extra.raw_info["location"]
      user.followers = auth.extra.raw_info["followers"]
      user.public_repos = auth.extra.raw_info["public_repos"]
    end

    user.save

    user
  end

end
