require './lib/addwalk'

Addwalk.configure do |c|
  c.app_id = "xxx"
  c.app_secret = "xxx"

  c.user_access_token = "xxx"
  c.user_access_token_secret = "xxx"
end

service_provider = Addwalk::ServiceProvider.new
sources = Addwalk::Source.new(service_provider.token, "test_widget_code").get(status: "untagged")