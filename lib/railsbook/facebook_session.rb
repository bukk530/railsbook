module RailsBook
  class FacebookSession
    
    class << self
      attr_accessor :appsecret_proof
    end
    
    def initialize(access_token, expires_at=0)
      if access_token.is_a? FacebookAccessToken
        @access_token = access_token
      else
        @access_token = FacebookAccessToken.new access_token, expires_at 
      end 
      @@appsecret_proof = true
    end
    
    def access_token
      @access_token.access_token
    end
    
    def expires_at
      @access_token.expires_at
    end
    
    def self.new_app_session
      self.new ENV["app_id"] + "|" + ENV["app_secret"]
    end
    
    
  end
end