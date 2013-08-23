module PlanetExpress
  class Configuration
    attr_accessor :gateway_url

    def initialize *args
      @gateway_url = 'http://transact5.silverpop.com/XTMail'
    end
  end
end
