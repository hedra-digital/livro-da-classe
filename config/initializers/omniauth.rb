OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "2byTz4MOQIyv3YoMHzFVEQ", "cRU6vQSh7pg5yZxRRPSu1HnSFNDSZI4SDmeo0ZcVV5I"
  provider :facebook, "462817203782895", "6ad0fab174bcd0d298195957fe68a48c"
  provider :google_oauth2, "1087006017149.apps.googleusercontent.com", "QrdEkoAt1AURclhddV7a8GP5"
end