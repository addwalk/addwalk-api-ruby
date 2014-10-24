module Addwalk
  class Brand < Addwalk::Resource

    def initialize token
      @token = token
      @model_name = "brand"
      @model_path = "brands"
    end

    def index params = {}
      params[:page_size] ||= 100
      params[:page] ||= 1

      super params
    end

  end
end
