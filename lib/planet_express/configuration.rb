module PlanetExpress
  class Configuration
    attr_accessor :gateway_url

    def initialize
      @gateway_url = 'https://transact5.silverpop.com/XTMail'
    end
  end
end
