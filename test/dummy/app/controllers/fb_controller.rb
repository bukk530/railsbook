require 'railsbook'

class FbController < ApplicationController
	def login
		
		fb_login_helper = RailsBook::FacebookRedirectLoginHelper.new "http://0.0.0.0:3000/" 
		
		fb_logout_url = fb_login_helper.get_logout_url nil, ""
		
		@url = fb_login_helper.get_login_url
		
	end
end