# config/initializers/iex_ruby_client.rb

IEX::Api.configure do |config|
  # config.publishable_token = 'pk_859b1e7fef6a47b49a68e6201e903e51'
  # config.secret_token = 'sk_ff034c1aa0364fe7a5c0dfce3c8abb87'
  config.publishable_token = 'pk_713deeec7e9e426ba75804937b4c18d4'
  config.secret_token = 'sk_89c4ec1aff6d42d6b512f7720aa180cc'
  config.endpoint = 'https://cloud.iexapis.com/v1' # or the appropriate API endpoint
end
