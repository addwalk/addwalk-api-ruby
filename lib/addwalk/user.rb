module Addwalk
  class User < Addwalk::Resource

    def initialize token, widget = false
      @token = token
      @widget = widget
    end

    def get params = {}

      params[:token] ||= @widget
      params[:status] ||= 'all'
      params[:page] ||= 1

      get_result( "sources", params )
    end

    def write

    end

    def create

    end

  end
end
