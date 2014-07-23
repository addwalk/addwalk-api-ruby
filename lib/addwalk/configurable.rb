module Addwalk
  module Configurable

    attr_accessor :app_id, :app_secret, :user_access_token, :user_access_token_secret

    class << self
      def keys
        @keys ||= [
          :app_id,
          :app_secret,
          :user_access_token,
          :user_access_token_secret
        ]
      end
    end

    def configure
      yield self
    end

  end
end