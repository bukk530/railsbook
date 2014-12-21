require 'railsbook'

class FbController < ApplicationController
  
	def show_login
		
		fb_login_helper = FacebookRedirectLoginHelper.new "http://webic.local:3000/login", session, params 
		
		#fb_logout_url = fb_login_helper.get_logout_url nil, ""
		
		@url = fb_login_helper.get_login_url
		
	end
	
	def login
	  
	  fb_login_helper = FacebookRedirectLoginHelper.new "http://webic.local:3000/login", session, params
	  
	  fb_session = fb_login_helper.get_session_from_redirect
	  
	  return render json: fb_session 
	  
	  
	end
	
end
