module NftmakerApi
  class Client::Projects
    def initialize(client)
      @client = client
    end

    def create(name:, policy_expires: true, policy_locks_at: Time.now.advance(months: 6), address_expires_in: 10)
      body = {projectname: name, maxNftSupply: 1, policyExpires: policy_expires, addressExpiretime: address_expires_in}
      body.merge!({ policyLocksDateTime: policy_locks_at.iso8601 }) if policy_expires

      @client.post "/CreateProject/#{@client.api_key}", body
    end

    def list
      @client.get "ListProjects/#{@client.api_key}"
    end
  end
end
