module Addwalk
  class Resource

    def version
      "1"
    end

    def url endpoint
      "/#{version}/#{endpoint}.json"
    end

    def headers
      { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      #{ 'Accept' => 'application/json', 'Content-Type' => 'application/x-www-form-urlencoded' }
    end


    # basic restful-actions
    def index params = {}
      params[:page] ||= 1
      check_result get_result( @model_path, params )
    end

    def create params = {}
      check_result post_result( @model_path, { @model_name.to_sym => params } )
    end

    def show id
      check_result get_result( "#{@model_path}/#{id}" )
    end

    def update id, params
      check_result put_result( "#{@model_path}/#{id}", { @model_name.to_sym => params } )
    end

    def destroy id
      check_result destroy_result( "#{@model_path}/#{id}" )
    end


    # request-types
    def get_result endpoint, params = {}
      @response = @token.get(url(endpoint), headers: headers, params: params)
      @result = JSON.parse(@response.body)
    end

    def post_result endpoint, params = {}
      @response = @token.post(url(endpoint), headers: headers, body: JSON.generate(params))
      @result = JSON.parse(@response.body)
    end

    def put_result endpoint, params = {}
      @response = @token.put(url(endpoint), headers: headers, body: JSON.generate(params))
      @result = JSON.parse(@response.body)
    end

    def destroy_result endpoint, params = {}
      @response = @token.delete(url(endpoint), headers: headers, params: params)
      @result = JSON.parse(@response.body)
    end


    private

    # check result -> and return the response
    def check_result result
      if result["response"] && result["response"]["success"] == true
        return recursive_symbolize_keys(result["response"])
      elsif result["response"].size > 0
        return recursive_symbolize_keys(result["response"])
      end
      return false
    end

    def recursive_symbolize_keys(h)
      case h
      when Hash
        Hash[
          h.map do |k, v|
            [ k.respond_to?(:to_sym) ? k.to_sym : k, recursive_symbolize_keys(v) ]
          end
        ]
      when Enumerable
        h.map { |v| recursive_symbolize_keys(v) }
      else
        h
      end
    end

  end
end
