Rails.application.routes.draw do
  get "/fb_login", to: "fb#show_login"
  get "/nigga",    to: "fb#nigga"
  get "/login",    to: "fb#login", as: :login
end
