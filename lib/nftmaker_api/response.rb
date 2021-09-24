require_relative "error"

module NftmakerApi
  class Response
    attr_reader :original_response
    alias_method :original, :original_response

    def initialize(response)
      @original_response = response
    end

    def parsed
      @parsed = Oj.load(@original_response.body) || {}
    end
    alias_method :to_h, :parsed

    def success?
      @original_response.status == 200
    end

    def error?
      !success?
    end

    def error
      @error ||= success? ? nil : Error.new(self)
    end
  end
end
