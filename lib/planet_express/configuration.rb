module PlanetExpress
  class Configuration
    attr_accessor :gateway_url

    def initialize *args
      @gateway_url = 'https://transact5.silverpop.com/XTMail'
    end
  end
end
