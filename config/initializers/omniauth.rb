OmniAuth.config.logger = Rails.logger
OmniAuth.config.on_failure = Proc.new do |env|
   SessionsController.action(:failure).call(env)
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENVied.FACEBOOK_APP_ID, ENVied.FACEBOOK_APP_SECRET
end

