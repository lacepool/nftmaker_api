require_relative "response"

module NftmakerApi
  class Client
    attr_reader :configuration, :api_key, :host, :last_response

    def initialize(options = {})
      @configuration = OpenStruct.new(
        NftmakerApi.configuration.to_h.merge(options)
      )

      @api_key = @configuration.api_key
      @host = @configuration.host
    end

    def projects
      Projects.new(self)
    end

    def project(id)
      Project.new(self, id)
    end

    def nfts
      Nfts.new(self)
    end

    def reservations(project_id:)
      Reservations.new(self, project_id: project_id)
    end

    def reservation(project_id:, address:)
      Reservation.new(self, project_id: project_id, address: address)
    end

    def get(endpoint)
      @last_response = Response.new(http_client.get endpoint)
    end

    def post(endpoint, body)
      response = http_client.post(endpoint) do |req|
        req.body = Oj.dump(body, mode: :compat)
      end

      @last_response = Response.new(response)
    end

    def http_client
      @http_client ||= Faraday.new(url: host, headers: {'Content-Type' => 'application/json'}) do |f|
        f.adapter configuration.http_adapter
      end
    end
  end
end
