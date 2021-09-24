module NftmakerApi
  class Client::Project
    def initialize(client, id)
      @client = client
      @id = id
    end

    def metrics
      @client.get "GetCounts/#{@client.api_key}/#{@id}"
    end

    def nfts
      NftmakerApi::Client::Nfts.new(@client, project_id: @id)
    end

    def reservations
      NftmakerApi::Client::Reservations.new(@client, project_id: @id)
    end

    def reservation(address)
      NftmakerApi::Client::Reservation.new(@client, project_id: @id, address: address)
    end
  end
end
