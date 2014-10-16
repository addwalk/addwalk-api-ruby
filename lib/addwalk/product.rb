module Addwalk
  class Product < Addwalk::Resource

    def initialize token
      @token = token
      @model_name = "product"
      @model_path = "products"
    end

  end
end
