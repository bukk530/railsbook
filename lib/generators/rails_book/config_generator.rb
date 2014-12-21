
module RailsBook
  class ConfigGenerator < Rails::Generators::Base
    source_root File.expand_path("templates", __FILE__)
    def create_config_file
      copy_file "../../templates/facebook.rb", "config/initializers/facebook.rb"
      copy_file "../../templates/facebook_app.yml", "config/facebook_app.yml"
    end
  end
end