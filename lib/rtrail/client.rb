require 'net/http'
require 'net/https'
require 'uri'
require 'json'
require 'hashie'

require_relative 'exceptions'

module RTrail
  class Client
    def initialize(base_url, user, password)
      @base_url = base_url
      @user = user
      @password = password
    end
    attr_reader :base_url, :user, :password

    # Send a GET request to the API and return a Hashie::Mash (for individual
    # object requests) or an Array of Hashie::Mash (for requests returning a
    # list of objects).
    #
    # @param [String] path
    #   The API method to call including parameters (e.g. get_case/1)
    #
    def get(path)
      _request(:get, path)
    end

    # Send a POST request to the API and return a Hashie::Mash.
    #
    # @param [String] path
    #   The API method to call including parameters (e.g. add_case/1)
    # @param [Hash] data
    #   The data to submit as part of the request. Strings must be UTF-8
    #   encoded.
    #
    def post(path, data={})
      _request(:post, path, data)
    end

    private

    # Send a GET or POST request to the given path, and return a
    # Hashie::Mash or Array of Hashie::Mash.
    #
    # @param [Symbol] method
    #   :get or :post
    #
    def _request(method, path, data=nil)
      url = URI.parse(@base_url + path)
      url_with_query = "#{url.path}?#{url.query}"

      if method == :post
        request = Net::HTTP::Post.new(url_with_query)
        request.body = JSON.dump(data)
      else
        request = Net::HTTP::Get.new(url_with_query)
      end

      request.basic_auth(@user, @password)
      request.add_field("Content-Type", "application/json")

      conn = Net::HTTP.new(url.host, url.port)
      if url.scheme == "https"
        conn.use_ssl = true
        conn.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      response = conn.request(request)
      return _result(response)
    end

    # Parse a Net::HTTPResponse as JSON, and return a Hashie::Mash,
    # or an Array of Hashie::Mash.
    #
    # @raise [RTrail::Error]
    #   If the response code is anything but 200 OK, if the response cannot be
    #   parsed as JSON, or if the parsed JSON is neither a Hash nor Array.
    #
    def _result(response)
      if response.body && !response.body.empty?
        begin
          result = JSON.parse(response.body)
        rescue => ex
          raise RTrail::Error.new(
            "Error parsing JSON response: #{ex.message}")
        end
      else
        result = {}
      end

      if response.code != "200"
        if result && result.key?("error")
          error = result["error"]
        else
          error = "Unknown error"
        end
        raise RTrail::Error.new(
          "TestRail API returned HTTP #{response.code} (#{error})")
      end

      if result.is_a?(Hash)
        return Hashie.new(result)
      elsif result.is_a?(Array)
        return result.map {|h| Hashie.new(h)}
      else
        raise RTrail::Error.new(
          "Unexpected result type: #{result.class.name}")
      end
    end

  end # class Client
end # module RTrail

