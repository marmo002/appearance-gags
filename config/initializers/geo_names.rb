GeoNames.configure do |config|
  config.username = Rails.application.credentials.geonames_api[:username]
end
