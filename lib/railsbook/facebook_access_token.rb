require 'date'

module RailsBook
  class FacebookAccessToken
    
    attr_reader :access_token, :expires_at, :machine_id
    
    def initialize(access_token, expires_at, machine_id=nil)
      @access_token = access_token
      @expires_at = Time.now + expires_at.to_i.seconds
      @machine_id = machine_id
    end
    
    def to_json
      { access_token: "[***]", expires_at: @expires_at }
    end
    
    def to_s
      to_json.to_s
    end
    
    def is_long_lived
      return (( Time.now + 2.hours ) - expires_at ).hours < 0 
    end
    
  end
end