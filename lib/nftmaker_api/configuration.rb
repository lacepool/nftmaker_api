module NftmakerApi
  class << self
    def configuration
      @configuration ||= OpenStruct.new(configuration_defaults)
    end

    def configuration_defaults
      {
        api_key: nil,
        host: "https://api.nft-maker.io",
        http_adapter: Faraday.default_adapter
      }
    end

    def configure
      yield(configuration)
    end

    def new(options = {})
      Client.new(options)
    end
  end
end

