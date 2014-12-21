fb_file = Rails.root + 'config/facebook_app.yml'
if !File.exists?(fb_file)
  raise "Facebook app config file not found"
end
yaml = YAML.load(File.open(fb_file))
ENV["app_id"] = yaml["app_id"].to_s
ENV["app_secret"] = yaml["app_secret"].to_s
