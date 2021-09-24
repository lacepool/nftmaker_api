module NftmakerApi
  class Client::Projects
    def initialize(client)
      @client = client
    end

    def list
      @client.get "ListProjects/#{@client.api_key}"
    end
  end
end
