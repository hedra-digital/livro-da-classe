OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "2byTz4MOQIyv3YoMHzFVEQ", "cRU6vQSh7pg5yZxRRPSu1HnSFNDSZI4SDmeo0ZcVV5I"
end
