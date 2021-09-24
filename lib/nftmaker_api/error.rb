module NftmakerApi
  class Error
    def initialize(response)
      @response = response
    end

    def to_s
      ["#{status} #{status_phrase}", reason].compact.join(", ")
    end

    def status
      @response.original.status
    end

    def status_phrase
      @response.original.reason_phrase
    end

    def reason
      @response.to_h.fetch("errorMessage") { nil }
    end
  end
end
