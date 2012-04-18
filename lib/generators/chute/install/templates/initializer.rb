# Use this hook to configure Chute API Credentials

Chute.configure do |config|
  config.app_id        = 'APP-ID'
  config.authorization = 'API-AUTH'
  config.api_endpoint  = 'http://api.getchute.com/v1'

  # specify your user model or set to nil.
  # each record belonging to this model will have a chute user account under your chute app account.
  # all assets / chutes belonging to objects of this model will belong to the corresponding chute user.
  config.user_model    = User
end
