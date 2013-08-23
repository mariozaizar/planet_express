module PlanetExpress
  class Delivery
    include Log4r

    attr_accessor :configuration
    attr_accessor :logger

    def initialize *args
      # Settings
      self.configuration ||= PlanetExpress::Configuration.new
      self.logger = Rails.logger
      logger.debug "gateway_url => #{configuration.gateway_url}"
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
      http.use_ssl  = url.scheme == 'https'
      logger.debug "SSL version: #{http.ssl_version.inspect}" if http.use_ssl?

      http.start do |h|
        path = url.path
        resp = h.post path, @request.to_s, { 'Content-type' => 'text/xml' }
      end

      build_response(resp.body)
    end

  private

    def build_request
      fields_xml = personalization_names = ''

      @personalizations.each_pair do |name, value|
        fields_xml +=
        "    <PERSONALIZATION>\n" +
        "      <TAG_NAME>#{name}</TAG_NAME>\n" +
        "      <VALUE><![CDATA[#{value}]]></VALUE>\n" +
        "    </PERSONALIZATION>\n"

        personalization_names +=
        "    <COLUMN_NAME>#{name}</COLUMN_NAME>\n"
      end

      recipient_xml =
        "  <RECIPIENT>\n" +
        "    <EMAIL>" + @recipient + "</EMAIL>\n" +
        "    <BODY_TYPE>HTML</BODY_TYPE>\n" +
        "#{fields_xml}" +
        "  </RECIPIENT>\n"

      # To save the personalization values in the Engage database,
      # you must create the fields in your database and use the SAVE_COLUMN
      # element for that XML tag.
      save_columns_xml =
        "  <SAVE_COLUMNS>\n" +
        "#{personalization_names}" +
        "  </SAVE_COLUMNS>\n"

      @request =
        "<?xml version='1.0' encoding='UTF-8' standalone='yes'?>\n" +
        "<XTMAILING>\n" +
        "  <CAMPAIGN_ID>#{@campaign_id}</CAMPAIGN_ID>\n" +
        "  <SHOW_ALL_SEND_DETAIL>true</SHOW_ALL_SEND_DETAIL>\n" +
        "  <SEND_AS_BATCH>false</SEND_AS_BATCH>\n" +
        "  <NO_RETRY_ON_FAILURE>false</NO_RETRY_ON_FAILURE>\n" +
        # "  <TRANSACTION_ID>" + @transaction_id + "</TRANSACTION_ID>\n" +

        "#{save_columns_xml}" +
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

      logger.error "Error: #{error_string}"       if status == 2
      logger.warn "Can't retrieve the response!"  if @response.nil?
      logger.info "Email (#{emails_sent}/#{recipients_received}) delivered."

      return response
    end
  end
end
