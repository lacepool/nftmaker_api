module NftmakerApi
  class NftFile
    def initialize(description: nil, url:, mime_type: nil, variables: nil)
      @description = description
      @mime_type = mime_type

      @variables = if variables
        variables.reduce([]) do |arr, var|
          arr << { name: var[0], value: var[1]}
        end
      end

      @url = if url.start_with? "ipfs"
        { fileFromIPFS: url }
      else
        { fileFromsUrl: url }
      end
    end

    def to_h
      hsh = { mimetype: @mime_type }
      hsh[:metadataPlaceholder] = @variables if @variables
      hsh.merge!(@url)
    end
  end
end
