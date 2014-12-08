
module RailsBook
  class ConfigGenerator < Rails::Generators::Base
    attr_reader :app_id, :app_secret
    desc "Creates a RailsBook configuration file at config/facebook_app.yml"
    argument :app_id, type: :string, optional: true
    argument :app_secret, type: :string, optional: true
    def self.source_root
      @_railsbook_source_root ||= File.expand_path("../templates", __FILE__)
    end
    def test
      puts "test"
    end
    def create_config_file
      template 'facebook_app.yml', File.join('config', "facebook_app.yml")
    end
  end
end