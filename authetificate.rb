require './lib/addwalk'

Addwalk.configure do |c|
  c.app_id = "9c94ee45fe7884d88ce7bf0f519738e45dbe2845386679b03d2ed8f8e45f41ff"
  c.app_secret = "3683fc6b22ccb04051109c4cae00c6c01063842088f92291554700758673edfd"

  c.user_access_token = "690be81cbd3bc2025e8b4d817712e9f3"
  c.user_access_token_secret = "cf12d822c5caf512272eeface9a83545"
end

service_provider = Addwalk::ServiceProvider.new
sources = Addwalk::Source.new(service_provider.token, "LlFMICO1ktemg4cXpO_v1Q").get(status: "untagged")

p sources