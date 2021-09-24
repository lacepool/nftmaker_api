module NftmakerApi
  class Client::Reservation
    def initialize(client, project_id:, address:)
      @client = client
      @project_id = project_id
      @address = address
    end

    def check
      @client.get "CheckAddress/#{@client.api_key}/#{@project_id}/#{@address}"
    end

    def cancel
      @client.get "CancelAddressReservation/#{@client.api_key}/#{@project_id}/#{@address}"
    end
  end
end
