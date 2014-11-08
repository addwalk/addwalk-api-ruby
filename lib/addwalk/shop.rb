module Addwalk
  class Shop < Addwalk::Resource

    def initialize token
      @token = token
      @model_name = "shop"
      @model_path = "shops"
    end

  end
end
