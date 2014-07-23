module Addwalk
  class ServiceProvider

    def initialize params = {}
      @app_id = Addwalk.app_id
      @app_secret = Addwalk.app_secret
      @user_access_token = Addwalk.user_access_token
      @user_access_token_secret = Addwalk.user_access_token_secret

      @api_endpoint = "http://api.addwalk.dev:3000/"  

      @client = OAuth2::Client.new(@app_id, @app_secret, site: @api_endpoint)
      @token = @client.password.get_token(@user_access_token, @user_access_token_secret)   
    end

    def client
      return @client
    end

    def token
      return @token
    end

  end
end