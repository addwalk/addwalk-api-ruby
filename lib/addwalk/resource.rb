module Addwalk
  class Resource

    def version
      "1"
    end

    def url endpoint
      "/#{version}/#{endpoint}.json"
    end

    def headers
      { 'Accept' => 'application/json', 'Content-Type' => 'application/x-www-form-urlencoded' }
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
      @response = @token.post(url(endpoint), headers: headers, params: params)
      @result = JSON.parse(@response.body)
    end

    def put_result endpoint, params = {}
      @response = @token.put(url(endpoint), headers: headers, params: params)
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
        return convert_result_keys_to_symbols(result["response"])
      elsif result["response"].size > 0
        return convert_result_keys_to_symbols(result["response"])
      end
      return false
    end

    # we want the result with symbols as keys and not strings, right?
    def convert_result_keys_to_symbols response
      return nil if !response
      new_hash = Hash.new

      response.each do |k,v|
        if(@model_name == k)
          new_hash[k.to_sym] = Hash.new
          unless v
            response_obj = nil
          else
            response_obj = v.each{ |k1,v1| new_hash[k.to_sym][k1.to_sym] = v1 }
          end
        else
          new_hash[k.to_sym] = v
        end
      end

      return new_hash
    end
  end
end
