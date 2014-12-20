Dir[File.dirname(File.absolute_path(__FILE__)) + "/railsbook/*.rb"].each do |file|
  require file
end

module RailsBook
    
    PHP_SDK_PORT_VERSION = "4.0.12"
    GRAPH_API_VERSION = "v2.2"
    BASE_GRAPH_URL = "https://graph.facebook.com"
    SDK_NAME = "RailsBook " + VERSION
    
end
