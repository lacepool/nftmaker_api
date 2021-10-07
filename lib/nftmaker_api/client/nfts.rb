module NftmakerApi
  class Client::Nfts
    def initialize(client, project_id: nil)
      @client = client
      @project_id = project_id
    end

    def list(state: :all)
      @client.get "GetNfts/#{@client.api_key}/#{@project_id}/#{state}"
    end
    alias_method :all, :list

    def free
      list(state: :free)
    end

    def reserved
      list(state: :reserved)
    end

    def sold
      list(state: :sold)
    end
  end
end
