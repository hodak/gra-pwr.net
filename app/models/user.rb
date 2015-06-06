class User < ActiveRecord::Base
  has_many :user_exams, dependent: :destroy
  has_many :exams, through: :user_exams
  has_many :user_answers
  has_many :answers, through: :user_answers

  default_scope { order('created_at ASC') }

  def self.omniauth(auth)
    where(provider_uid: auth.uid, provider: auth.provider).first_or_initialize.tap do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.image = auth.info.image
      user.token = auth.credentials.token
      user.expires_at = DateTime.now + auth.credentials.expires_at.seconds

      user.save!
    end
  end
end
