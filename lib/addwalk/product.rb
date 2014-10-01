module Addwalk
  class Product < Addwalk::Resource

    def initialize token
      @token = token
      @model_name = "product"
      @model_path = "products"
    end

    def index params = {}
      params[:token] ||= nil
      params[:status] ||= 'all'
      params[:page] ||= 1

      super params
    end

  end
end
