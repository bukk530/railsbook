module RailsBook
  class FacebookResponse
    
    attr_reader :request, :response, :etag_hit, :etag
    
    def initialize(request, response, etag_hit = false, etag = nil)
      @request = request
      @response = response
      @etag_hit = etag_hit
      @etag = etag
    end
    
  end
end