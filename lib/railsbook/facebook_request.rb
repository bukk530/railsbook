require 'digest'
require 'json'
require 'openssl'
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
      
      url = url + "?" + URI.encode_www_form(params)
      params = []
      
      url = URI.parse(url)
      
      cert_path = File.dirname(__FILE__) << "/fb_ca_chain_bundle.crt"
      
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      #http.cert = OpenSSL::X509::Certificate.new( cert_path )
      #http.key = OpenSSL::PKey::RSA.new( cert_path )
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE #TODO: WTF??? check peer!
      
      request = Net::HTTP::Get.new(url.request_uri)
      request.add_field "User-Agent", "railsbook-" + VERSION
      request.add_field "Accept-Encoding", "*"
      request.add_field "If-None-Match", @etag if !@etag.nil?
      
      response = http.request(request)
      
      etag_hit = 304 == response.code
      
      etag_received = response.header[:etag]
      
      decoded_result = { } 
      
      #strange things happends here, the response is not json, errors are!
      begin
        result = URI::decode_www_form response.body
        result.each { |r| decoded_result[ r[0] ] = r[1] }
      rescue
        error = JSON.parse response.body
        raise FacebookRequestException.new "Error: " << error["error"]["message"] if error["error"].present?
      end
       
      raise FacebookRequestException.new "Error: no response from Facebook OAuth server" if decoded_result.nil?
      
      FacebookResponse.new self, decoded_result, etag_hit, etag_received
      
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
