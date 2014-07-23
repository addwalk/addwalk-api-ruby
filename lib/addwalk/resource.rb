module Addwalk  
  class Resource
    
    def version 
      "1"
    end

    def url endpoint
      "/#{version}/#{endpoint}.json"
    end

    def headers
      { 'Accept' => 'application/json' }
    end

    def get_result endpoint, params = {}
      @response = @token.get(url(endpoint), headers: headers, params: params)
      @result = JSON.parse(@response.body)
    end

  end
end