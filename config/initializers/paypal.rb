PayPal::SDK::Core::Config.load('config/paypal.yml',  ENV['RACK_ENV'] || 'development')
# PayPal::SDK.logger = Rails.logger
PayPal::SDK.logger.level = Logger::INFO
