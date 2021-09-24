module NftmakerApi
  class Client::Reservations
    def initialize(client, project_id:)
      @client = client
      @project_id = project_id
    end

    def create(nft_id: nil, nft_count:, lovelace:)
      if nft_id.blank?
        endpoint = "GetAddressForRandomNftSale/#{@client.api_key}/#{@project_id}/#{nft_count}/#{lovelace}"
      else
        endpoint = "GetAddressForSpecificNftSale/#{@client.api_key}/#{@project_id}/#{nft_id}/#{nft_count}/#{lovelace}"
      end

      @client.get endpoint
    end
  end
end
