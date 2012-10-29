require 'hpricot'
require 'net/http'
require 'uri'

require "planet_express/version"
require "planet_express/delivery"
require "planet_express/configuration"

module PlanetExpress
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= PlanetExpress::Configuration.new
    yield(configuration)
  end
end
