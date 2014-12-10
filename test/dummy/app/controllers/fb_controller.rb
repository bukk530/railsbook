require 'railsbook'

class FbController < ApplicationController
  
	def show_login
		
		fb_login_helper = FacebookRedirectLoginHelper.new "http://webic.local:3000/fb_login", session, params 
		
		#fb_logout_url = fb_login_helper.get_logout_url nil, ""
		
		@url = fb_login_helper.get_login_url
		
	end
	
	def login
	  
	  session = get_session_from_redirect
	  
	end
	
end
