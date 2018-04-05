PayPal::SDK::Core::Config.load('config/paypal.yml',  ENV['RACK_ENV'] || 'production')
# PayPal::SDK.logger = Rails.logger
PayPal::SDK.logger.level = Logger::INFO
