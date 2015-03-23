require 'digest'
require 'json'
require 'openssl'
require 'net/http'
require 'uri'

module RailsBook
  class FacebookRequest
    
    def initialize(session, method, path, parameters=nil, etag=nil)
      @session      = session
      @method       = method
      @path         = URI.encode(path)
      @etag         = etag
      @params       = parameters || { }
      
      if @session.is_a? String
         @params[:access_token] = @session
      end
      if FacebookSession::appsecret_proof and ( @params.nil? or !@params[:appsecret_prof].present? )
          @params[:appsecret_proof] = get_appsecret_proof params[:access_token] 
      end
    end
    
    def execute
      url = get_request_url
      params = @params
      
      if @method == 'GET'
        url += ( url.include?('?') ? '&' : '?' ) + URI.encode_www_form(params)
      end
      
      url = URI.parse(url)
      
      cert_path = File.dirname(__FILE__) + "/fb_ca_chain_bundle.crt"
      
      # To avoid reading the file from the disk each time
      # we save it into memory
      certificate = Rails.cache.fetch('railsbook/certificate') do
        File.read(cert_path)
      end
      
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.cert = OpenSSL::X509::Certificate.new certificate 
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      
      if @method == 'GET'
        request      = Net::HTTP::Get.new(url.request_uri)
      elsif @method == 'POST'
        request      = Net::HTTP::Post.new(url.request_uri)
      elsif @method == 'DELETE'
        request      = Net::HTTP::Delete.new(url.request_uri)
      end
      
      request.body = URI::encode_www_form @params unless @params.empty? or @method == 'GET'
      request.add_field "User-Agent", "railsbook-" + VERSION
      request.add_field "Accept-Encoding", "*"
      request.add_field "If-None-Match", @etag if !@etag.nil?
      
      response = http.request(request)
      
      etag_hit = 304 == response.code
      
      etag_received = response.header[:etag]
      
      decoded_result = { } 
      
      # Strange things happends here, the response could be either json or url encoded
      # We assume that if the response starts with a '{' it is json
      if response.body[0] == '{'
        decoded_result = JSON.parse response.body
      else
        result = URI::decode_www_form response.body
        result.each { |r| decoded_result[ r[0] ] = r[1] }
      end 
      
      raise FacebookRequestException.new "Error: no response from Facebook OAuth server" if decoded_result.nil? or decoded_result.empty?
      
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
