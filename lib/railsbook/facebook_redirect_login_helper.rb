require 'securerandom'
require 'uri'

#TODO: Implement this class as a Rails Helper class

module RailsBook
  
  class FacebookRedirectLoginHelper
    
    def initialize(redirect_url, session, params)
      @redirect_url = redirect_url
      @session = session
      @params = params
    end
    
    # Params:
    #   -scope
    #   -display_as_popup
    def get_login_url(options={})
      
      @state = random_bytes(16)
      @session[:_fb_state] = @state
      
      uri_params = {
        client_id:      ENV["app_id"],
        redirect_uri:   @redirect_url,
        state:          @state,
        sdk:            RailsBook::SDK_NAME
      }
      
      uri_params[:scope] = options[:scope].join(',') unless options[:scope].nil?
      
      uri_params[:display] = :popup if options[:display_as_popup]
      
      return "https://www.facebook.com/" +
              RailsBook::GRAPH_API_VERSION +
              "/dialog/oauth?" +
              URI.encode_www_form(uri_params)
    end
    
    def get_logout_url(session, next_page)
      if !session.instance_of? FacebookSession
        raise FacebookSDKException.new "not a valid session"
      end
      
      uri_params = {
        next:           next_page,
        access_token:   session.get_token 
      }
      
      return "https://www.facebook.com/logout.php?" +
             URI.encode_www_form(uri_params)
    end
    
    def get_session_from_redirect
      @state = get_state
      if is_valid_redirect
        response_params = {
          client_id: ENV["app_id"],
          redirect_uri: @redirect_url,
          client_secret: ENV["app_secret"],
          code: get_code
        }
        facebook_response = FacebookRequest.new( FacebookSession::new_app_session,
                                                 "GET",
                                                 "/oauth/access_token",
                                                 response_params
                                                ).execute.response
        
        if facebook_response["access_token"].present? 
          return FacebookSession.new( facebook_response["access_token"], facebook_response["expires"] || 0 )
        end
      end
      nil
    end
    
    private 
    
    def is_valid_redirect
      !get_code.nil? and 
      get_state.eql? @params[:state]
    end
    
    def get_state
      @session[:_fb_state]
    end
    
    def get_code
      @params[:code]
    end
    
    def random_bytes(bytes)
      if !bytes.is_a? Integer
        raise FacebookSDKException.new "random expects an integer"
      end
      if bytes < 1
        raise FacebookSDKException.new "random expects an integer greater than zero"
      end
      SecureRandom.hex(bytes)
    end
    
  end
end
