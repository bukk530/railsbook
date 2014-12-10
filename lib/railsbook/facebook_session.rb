module RailsBook
  class FacebookSession
    
    attr_reader :access_token
    
    class << self
      attr_accessor :appsecret_proof
    end
    
    def initialize(access_token, signed_request = nil)
      if access_token.is_a? FacebookAccessToken
        @access_token = access_token
      else
        @access_token = FacebookAccessToken.new access_token
      end 
      @@appsecret_proof = true
    end
    
    def new_app_session
      self.class.new ENV["app_id"] + "|" + ENV["app_secret"]
    end
    
    
  end
end