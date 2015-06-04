OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENVied.FACEBOOK_APP_ID, ENVied.FACEBOOK_APP_SECRET
end
