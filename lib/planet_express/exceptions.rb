module PlanetExpress
  class Error < StandardError; end
  class ArgumentError < ArgumentError;
    def message
      "Missing data. Please provide the campaign_id, recipient email and the personalizations hash."
    end
  end
end
