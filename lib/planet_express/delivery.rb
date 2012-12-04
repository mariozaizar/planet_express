module PlanetExpress
  class Delivery
    include Log4r

    attr_accessor :configuration
    attr_accessor :logger

    def initialize *args
      # Settings
      self.configuration ||= PlanetExpress::Configuration.new

      # By default try to use the same logger than Rails
      begin
        self.logger = Rails.logger
      rescue
        self.logger = Log4r::Logger.new('PlanetExpress')
        self.logger.outputters << Log4r::Outputter.stdout
      end

      logger.info "gateway_url => #{configuration.gateway_url}"
    end

    def configure
      # Override Settings
      yield(configuration)
    end

    def prepare campaign_id, recipient, personalizations={}
      @campaign_id, @recipient, @personalizations = campaign_id, recipient, personalizations
      @personalizations.merge!({ :timestamp => Time.now, :email_template => @campaign_id })
      raise PlanetExpress::ArgumentError if campaign_id.nil? or recipient.nil?

      build_request
    end

    def deliver!
      url = URI.parse configuration.gateway_url
      http, resp    = Net::HTTP.new(url.host, url.port), ''
      http.use_ssl  = true

      http.start do |h|
        path = url.path
        resp = h.post path, @request.to_s, { 'Content-type' => 'text/xml' }
      end

      build_response(resp.body)
    end

  private

    def build_request
      fields_xml = ''

      @personalizations.each_pair do |name, value|
        fields_xml +=
        "    <PERSONALIZATION>\n" +
        "      <TAG_NAME>#{name}</TAG_NAME>\n" +
        "      <VALUE><![CDATA[#{value}]]></VALUE>\n" +
        "    </PERSONALIZATION>\n"
      end

      recipient_xml =
        "  <RECIPIENT>\n" +
        "    <EMAIL>" + @recipient + "</EMAIL>\n" +
        "    <BODY_TYPE>HTML</BODY_TYPE>\n" +
        "#{fields_xml}" +
        "  </RECIPIENT>\n"

      @request =
        "<?xml version='1.0' encoding='UTF-8' standalone='yes'?>\n" +
        "<XTMAILING>\n" +
        "  <CAMPAIGN_ID>#{@campaign_id}</CAMPAIGN_ID>\n" +
        "  <SHOW_ALL_SEND_DETAIL>true</SHOW_ALL_SEND_DETAIL>\n" +
        "  <SEND_AS_BATCH>false</SEND_AS_BATCH>\n" +
        "  <NO_RETRY_ON_FAILURE>false</NO_RETRY_ON_FAILURE>\n" +
        # "  <TRANSACTION_ID>" + @transaction_id + "</TRANSACTION_ID>\n" +
        "#{recipient_xml}" +
        "</XTMAILING>\n"

      logger.info "original request => \n#{@request}"
      @request
    end

    def build_response response
      logger.info "original response => \n#{response}"
      @response = Hpricot::XML(response)

      status              = @response.at('STATUS').innerHTML.to_i
      error_string        = @response.at('ERROR_STRING').innerHTML
      recipients_received = @response.at('RECIPIENTS_RECEIVED').innerHTML
      emails_sent         = @response.at('EMAILS_SENT').innerHTML

      return { status: false, emails_sent: emails_sent, recipients_received: recipients_received, message: 'The request has not been executed.' } if @response.nil?
      return { status: false, emails_sent: emails_sent, recipients_received: recipients_received, message: error_string } if status == 2
      return { status: true,  emails_sent: emails_sent, recipients_received: recipients_received } if status == 0
    end
  end
end
