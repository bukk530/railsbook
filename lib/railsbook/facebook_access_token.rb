require 'date'

module RailsBook
  class FacebookAccessToken
    
    attr_reader :expires_at, :machine_id
    
    def initialize(access_token, expires_at=0, machine_id=nil)
      @access_token = access_token
      @expires_at = Time.at(expires_at).to_datetime
      @machine_id = machine_id
    end
    
    def is_long_lived
      return (( Time.now + 2.hours ) - expires_at ).hours < 0 
    end
    
  end
end