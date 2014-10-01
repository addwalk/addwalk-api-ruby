module Addwalk
  class Category < Addwalk::Resource

    def initialize token
      @token = token
      @model_name = "category"
      @model_path = "categories"
    end

    def index params = {}
      params[:token] ||= nil
      params[:page] ||= 1

      super params
    end

  end
end
