
class FbController < ApplicationController
  
	def show_login
		
		fb_login_helper = FacebookRedirectLoginHelper.new login_url, session, params 
		
		#fb_logout_url = fb_login_helper.get_logout_url nil, ""
		
		@url = fb_login_helper.get_login_url scope: ['manage_pages', 'friends_likes']
		
	end
	
	def login
	  
	  fb_login_helper = FacebookRedirectLoginHelper.new login_url, session, params
	  
	  fb_session = fb_login_helper.get_session_from_redirect
	  
	  unless fb_session.nil?
	   session[:fb_access_token] = fb_session.access_token
	  end
	  
	  return render json: session[:fb_access_token]
	  
	end
	
	def nigga
	  
    @response1 = FacebookRequest.new(session[:fb_access_token], 
                                    'GET', '/me').execute.response
                                    
    @response = FacebookRequest.new('CAACEdEose0cBACigXtjOeZCJOUZC1tElyRdUc0YHvSwrqXIcSjNmPWjT68NubJZCSudtSOrZBH2XknZBA7QMXhbdt1m7I0g60w2AyhzZASuAlAGOVpF4R4sDkQ93OPocmdJderPET3GZCfCOOGgnG0CTWKmlYjZAW0N3RQ0zrSWuO8eUaJY7UOFB5ZCKgYPYgCsgZD',
                                    'POST', '/1613822575513090/tabs', { app_id: 1397360337227081 }).execute.response
    
    @response = FacebookRequest.new('CAACEdEose0cBACigXtjOeZCJOUZC1tElyRdUc0YHvSwrqXIcSjNmPWjT68NubJZCSudtSOrZBH2XknZBA7QMXhbdt1m7I0g60w2AyhzZASuAlAGOVpF4R4sDkQ93OPocmdJderPET3GZCfCOOGgnG0CTWKmlYjZAW0N3RQ0zrSWuO8eUaJY7UOFB5ZCKgYPYgCsgZD',
                                    'POST', '/1613822575513090/tabs/app_1397360337227081', { position: 2 }).execute.response
                                    
	  return render json: @response
	end
	
end
