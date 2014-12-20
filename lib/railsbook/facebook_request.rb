require 'digest'
require 'json'
require 'net/http'
require 'uri'

module RailsBook
  class FacebookRequest
    
    def initialize(session, method, path, parameters=nil, etag=nil)
      @session = session
      @method = method
      @path = path
      @etag = etag
      @params = parameters || []
      
      if session and
         @params[:access_token].present?
         
          @params[:access_token] = session.access_token
         
      end
      if FacebookSession::appsecret_proof and
         !@params[:appsecret_prof].present?
          
          @params[:appsecret_proof] = get_appsecret_proof params[:access_token]
          
      end
    end
    
    def execute
      url = get_request_url
      params = @params
      
      raise FacebookSDKNotImplemented "POST method not implemented" if @method == "POST"
      
      url = url + "?" + URL.encode_www_params(params)
      params = []
      
      url = URI.parse(url)
      
      http = Net::HTTP.new(url, 443)
      request = Net::HTTP::Get.new(url.request_uri)
      request.add_field "User-Agent", "railsbook-" + VERSION
      request.add_field "Accept-Encoding", "*"
      request.add_field "If-None-Match", @etag if !@etag.nil?
      
      response = http.request(request)
      
      etag_hit = 304 == response.code
      
      etag_received = response.header[:etag]
      
      decoded_result = json.parse(response.body)
      
      #TODO: check for errorss
      
      FacebookResponse.new this, decoded_result, result, etag_hit, etag_received
      
    end
    
    
    private
    
    def get_request_url
      BASE_GRAPH_URL + "/" + GRAPH_API_VERSION + @path
    end
    
    def get_appsecret_proof token
      Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), ENV["app_secret"], token)).strip()
    end
    
  end
end
