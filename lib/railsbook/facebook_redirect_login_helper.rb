require 'securerandom'
require 'addressable/uri'

module RailsBook
  class FacebookRedirectLoginHelper
    def initialize
      
    end
    
    def get_login_url(scope = [], display_as_popup=false)
      random = random_bytes(16)
      uri = Addressable::URI.new
      uri_params = {
        client_id: ENV["app_id"],
        redirect_uri: self.redirect_url,
        sdk: RailsBook::SDK_NAME,
        auth_type: :request,
        scope: scope.join(",")
      }
      uri.query_values = uri_params
      return "https://www.facebook.com/" +
              RailsBook::GRAPH_API_VERSION +
              "/dialog/oauth?" +
              uri.query
    end
    
    def get_logout_url(session, next_page)
      if !session.instance_of? FacebookSession
        raise FacebookSDKException "not a valid session"
      end
      uri = Addressable::URI.new
      uri_params = {
        
      }
      uri.query_values = uri_params
      return "https://www.facebook.com/logout.php?" +
             uri.query
    end
    
    def random_bytes(bytes)
      if !bytes.is_a Integer
        raise FacebookSDKException "random expects an integer"
      end
      if bytes < 1
        raise FacebookSDKException "random expects an integer greater than zero"
      end
      SecureRandom.hex(bytes)
    end
    
  end
end