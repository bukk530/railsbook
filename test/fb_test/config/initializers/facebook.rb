fb_file = Rails.root + 'config/facebook_app.yml'
YAML.load(File.open(fb_file)).each do |key, value|
  ENV[key.to_s] = value
end if File.exists?(fb_file)