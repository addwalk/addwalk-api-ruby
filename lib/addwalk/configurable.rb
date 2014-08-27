module Addwalk
  module Configurable

    attr_accessor :app_id, :app_secret, :user_access_token, :user_access_token_secret, :api_endpoint

    class << self
      def keys
        @keys ||= [
          :app_id,
          :app_secret,
          :user_access_token,
          :user_access_token_secret,
          :api_endpoint,
        ]
      end
    end

    def configure
      yield self
    end

  end
end
