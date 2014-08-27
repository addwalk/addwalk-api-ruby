module Addwalk
  class SourceSet < Addwalk::Resource

    def initialize token
      @token = token
      @model_name = "source_set"
      @model_path = "source_sets"
    end

  end
end
