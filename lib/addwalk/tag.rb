module Addwalk
  class Tag < Addwalk::Resource

    def initialize token
      @token = token
      @model_name = "tag"
      @model_path = "tags"
    end

    def index params = {}
      params[:type] ||= 'all'
      params[:page] ||= 1

      super params
    end

  end
end
