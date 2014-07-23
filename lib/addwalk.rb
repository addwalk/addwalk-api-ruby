require 'oauth2'
require 'json'

require './lib/addwalk/configurable'
require './lib/addwalk/service_provider'
require './lib/addwalk/resource'
require './lib/addwalk/source'

module Addwalk
  class << self

    include Addwalk::Configurable

  end
end