module RailsBook
  class FacebookResponse
    
    attr_reader :request, :response, :raw_response, :etag_hit, :etag
    
    def initialize(request, response_data, raw_response, etag_hit = false, etag = nil)
      @request = request
      @response_data = response_data
      @raw_response = raw_response
      @etag_hit = etag_hit
      @etag = etag
    end
    
  end
end