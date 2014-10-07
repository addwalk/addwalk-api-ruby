module Addwalk
  class Source < Addwalk::Resource

    def initialize token
      @token = token
      @model_name = "source"
      @model_path = "sources"
    end
    
  end
end
