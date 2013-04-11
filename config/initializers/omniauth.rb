OmniAuth.config.logger = Rails.logger

if Rails.env.production?
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, "2byTz4MOQIyv3YoMHzFVEQ", "cRU6vQSh7pg5yZxRRPSu1HnSFNDSZI4SDmeo0ZcVV5I"
    provider :facebook, "462817203782895", "6ad0fab174bcd0d298195957fe68a48c"
    provider :google_oauth2, "1087006017149.apps.googleusercontent.com", "QrdEkoAt1AURclhddV7a8GP5"
  end
elsif Rails.env.demo?
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, "g2pgUJetYRoDTePZ4TcyQ", "LkRyPuYWRT2g0bq543E3uKbjoDrcUkQCZImZfLHqJg"
    provider :facebook, "462817203782895", "6ad0fab174bcd0d298195957fe68a48c"
    provider :google_oauth2, "1087006017149-t8ad3ej20ib46kqs33638avmsu7kr3fo.apps.googleusercontent.com", "Z1C7hirHxUe25zgLq5oGshsC"
  end
elsif Rails.env.staging? || Rails.env.test?
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, "HFwmE8CdAqLrgMjQROw8g", "FjHG7WEOEGF9zS15UrK1DS2bKFuVVcLsPzVJasqpU"
    provider :facebook, "462817203782895", "6ad0fab174bcd0d298195957fe68a48c"
    provider :google_oauth2, "1087006017149-trcfrjjs4fg5ftjsmp8dpd1oai84vifu.apps.googleusercontent.com", "1maEZuCXHaFwYiQF_cXIjBY2"
  end
end
