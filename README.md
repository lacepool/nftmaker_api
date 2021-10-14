[![Build Status](https://github.com/lacepool/nftmaker_api/workflows/CI/badge.svg?branch=main)](https://github.com/lacepool/nftmaker_api/actions)

# NftmakerApi

A Ruby client for the https://nft-maker.io/pro API.

It aims to support all API methods. The intuitive query methods allow to easily call the API endpoints.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nftmaker_api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install nftmaker_api

## Configuration

The configuration options can be set by using the `configure` block

```ruby
NftmakerApi.configure do |config|
  config.api_key = ENV.fetch('NFT_MAKER_PRO_API_KEY')
end
```

Alternatively, you can configure the settings by passing a hash of options to an instance like so

```ruby
client = NftmakerApi.new api_key: "xyz",
                         http_adapter: :typhoeus
```

The following is the list of available configuration options

```ruby
api_key      # The API key provided by nft-maker.io
http_adapter # The http client used for performing requests. Default :net_http
host         # The API endpoint. Default: https://api.nft-maker.io
```

## 1 Usage

To start using the gem, you first create a new client instance

```ruby
client = NftmakerApi.new
```

and then you call the methods for the API endpoints.

### 1.1 Endpoints

List all projects

```ruby
client.projects.list
```

Show metrics for a project

```ruby
client.project(1634).metrics
```

List all NFTs for a project

```ruby
client.project(1634).nfts.list     # all
client.project(1634).nfts.sold     # only sold
client.project(1634).nfts.free     # only free
client.project(1634).nfts.reserved # only reserved
```

Create NFTS for a project

Please note: The API expects metadata variables to be passed with the files even though they're not only applied within the scope of the files. By passing variables with the preview image you can also replace placeholders unrelated to the image.

```ruby

vars = {
  custom_name: "StarTrek Series #1",
  creature: "Vulcan",
  traits: "pointed ears, green blood, slanted eyebrows"
}

thumbnail = NftmakerApi::NftFile.new(url: "https://xyz.com/thumbnail.png", variables: vars, mime_type: "image/png")
highres_1 = NftmakerApi::NftFile.new(url: "https://xyz.com/highres_1.png", mime_type: "image/png")
highres_2 = NftmakerApi::NftFile.new(url: "https://xyz.com/highres_2.png", mime_type: "image/png")

client.project(1634).nfts.create(
  asset_name: "StarTrek01",
  preview_file: thumbnail,
  files: [highres_file_1, highres_file_2]
)

# This results in following metadata

{
  "721": {
    "a0a7f00ccd9344d15ca0c7eb22c326979f7d65690266afcb128332db": {
      "StarTrek01": {
        "name": "StarTrek Series #1",
        "image": "ifps://xyzThumbnail",
        "mediaType": "image/png",
        "creature": "Vulcan",
        "traits": "pointed ears, green blood, slanted eyebrows",
        "files": [
          {
            "name": "StarTrek Series #1",
            "mediaType": "image/png",
            "src": "ipfs://xyzHighres1"
          },
          {
            "name": "StarTrek Series #1",
            "mediaType": "image/png",
            "src": "ipfs://xyzHighres2"
          }
        ]
      }
    },
    "version": "1.0"
  }
}

```

Create a new project

```ruby
client.projects.create(name: "Foo", policy_expires: true, policy_locks_at: Time.now.advance(months: 6), address_expires_in: 10)
```

Reserve NFT(s) from a project

```ruby
client.project(1634).reservations.create(nft_count: 1, lovelace: 10_000000)              # Reserve a random NFT
client.project(1634).reservations.create(nft_id: 123, nft_count: 1, lovelace: 10_000000) # Reserve a specific NFT
```

Check / Cancel a reservation

```ruby
client.project(1634).reservation("addr1...").check
client.project(1634).reservation("addr1...").cancel
```

## 2 Response Handling

Responses are wrapped into a `NftmakerApi::Response` object. The main reason is to allow direct access to the parsed JSON response body.

Sidenote: The JSON body is parsed using [Oj](https://github.com/ohler55/oj) which is a C implementation, hence much faster than [JSON from Ruby's Standard Library](https://ruby-doc.org/stdlib-3.0.2/libdoc/json/rdoc/JSON.html).



```ruby
client.projects.list.to_h
# => [{"id"=>123, "projectname" => "Foo", ...}, ...]
```

Access the original faraday response object

```ruby
client.projects.list.original_response
```

### 2.1 Errors

Check if the request was successful or returned an error

```ruby
client.projects.list.success?
client.projects.list.error?
```

Response errors are always `NftmakerApi::Error` objects.

```ruby
client.projects.list.error
```

Show error message including status code, status phrase and the actual error message from the API

```ruby
client.projects.list.error.full_message
```

Show status code

```ruby
client.projects.list.error.status
```

Show error message returned from the API

```ruby
client.projects.list.error.reason
```

## 3 Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lacepool/nftmaker_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the Contributor Covenant code of conduct.


## 4 License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
