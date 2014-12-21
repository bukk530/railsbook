Rails.application.routes.draw do
  
  get "/fb_login", to: "fb#show_login"
  get "/login", to: "fb#login"
  
end
