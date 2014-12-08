# encoding: utf-8
require "rails/generators/named_base"

module RailsBook
  module Generators
    class Base < ::Rails::Generators::NamedBase
      def self.source_root
        @_railsbook_source_root ||=
        File.expand_path("../#{base_name}/#{generator_name}/templates", __FILE__)
      end
    end
  end
end
