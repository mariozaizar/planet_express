require 'net/http'
require 'uri'
require 'hpricot'

require "planet_express/version"
require "planet_express/delivery"

module PlanetExpress
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= PlanetExpress::Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :gateway_url

    def initialize
      @gateway_url = 'https://transact5.silverpop.com/XTMail'
    end
  end
end
