require_relative "../nft_file"

module NftmakerApi
  class Client::Nfts
    def initialize(client, project_id: nil)
      @client = client
      @project_id = project_id
    end

    def create(asset_name:, preview_file:, files: [])
      unless preview_file.respond_to?(:to_h)
        raise ArgumentError "preview_file parameter was given #{preview_file} as an argument but does not implement #to_h method."
      end

      unless files.respond_to?(:any?)
        raise ArgumentError "files parameter was given #{files} as an argument but does not seem to quack like an array."
      end

      subfiles = {}
      subfiles[:subfiles] = files.map(&:to_h) if files.any?

      body = { assetName: asset_name, previewImageNft: preview_file.to_h }.merge!(subfiles)

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
