require 'railsbook'

class FbController < ApplicationController
	def login
		
		fb_login_helper = RailsBook::FacebookRedirectLoginHelper.new 
		
		@url = fb_login_helper.get_login_url
		
	end
end
