require 'oauth2'
require 'json'

require './lib/addwalk/configurable'
require './lib/addwalk/service_provider'
require './lib/addwalk/resource'

# model-endpoints
require './lib/addwalk/category'
require './lib/addwalk/tag'
require './lib/addwalk/source'
require './lib/addwalk/source_set'
require './lib/addwalk/product'

module Addwalk
  class << self

    include Addwalk::Configurable

  end
end
