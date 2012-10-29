module PlanetExpress
  class Delivery
    # FIXME This requires Rails, so this lib won't work without Rails
    # cattr_accessor :logger

    # TODO replace this with log4r
    # self.logger = Logger.new(STDOUT)

    def prepare campaign_id, recipient, personalizations={}
      # Is a better way to do this?
      @campaign_id      = campaign_id
      @recipient        = recipient
      @personalizations = personalizations

      # logger.info "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
      # logger.info "campaign_id  => #{@campaign_id}"
      # logger.info "recipient    => #{@recipient}"
      # logger.info "personalizations (#{@personalizations.count}) => #{@personalizations}"

      @personalizations.merge!({ :timestamp => Time.now, :email_template => @campaign_id })
      build_request
    end

    def deliver!
      url = URI.parse PlanetExpress::configuration.gateway_url
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
        "<PERSONALIZATION>" +
        "  <TAG_NAME>#{name}</TAG_NAME>" +
        "  <VALUE><![CDATA[#{value}]]></VALUE>" +
        "</PERSONALIZATION>"
      end

      recipient_xml =
        "<RECIPIENT>" +
        "  <EMAIL>" + @recipient + "</EMAIL>" +
        "  <BODY_TYPE>HTML</BODY_TYPE>" +
        "  #{fields_xml}" +
        "</RECIPIENT>"

      @request =
        "<?xml version='1.0' encoding='UTF-8' standalone='yes'?>" +
        "<XTMAILING>" +
        "  <CAMPAIGN_ID>#{@campaign_id}</CAMPAIGN_ID>" +
        "  <SHOW_ALL_SEND_DETAIL>true</SHOW_ALL_SEND_DETAIL>" +
        "  <SEND_AS_BATCH>false</SEND_AS_BATCH>" +
        "  <NO_RETRY_ON_FAILURE>false</NO_RETRY_ON_FAILURE>" +
        # "  <TRANSACTION_ID>" + @transaction_id + "</TRANSACTION_ID>" +
        "  #{recipient_xml}" +
        "</XTMAILING>"

      # logger.info "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
      # logger.info "request => #{@request}"

      @request
    end

    def build_response response
      @response = Hpricot::XML(response)
      # logger.info "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
      # logger.info "response => #{response.inspect}"

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
