module NftmakerApi
  class Client::Nfts
    def initialize(client, project_id: nil)
      @client = client
      @project_id = project_id
    end

    def create(name:, file_url:, mime_type:, description: nil, metadata_vars: nil)
      file_url_hash = if file_url.start_with? "ipfs"
        { fileFromIPFS: file_url }
      else
        { fileFromsUrl: file_url }
      end

      body = {
        assetName: name,
        previewImageNft: {
          mimetype: mime_type,
          description: description,
          metadataPlaceholder: metadata_vars,
        }.merge!(file_url_hash)
      }

      @client.post "UploadNft/#{@client.api_key}/#{@project_id}", body
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
