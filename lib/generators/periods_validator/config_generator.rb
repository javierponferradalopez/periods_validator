# frozen_string_literal: true

module PeriodsValidator
  module Generators
    # rails g periods_validator:config
    class ConfigGenerator < Rails::Generators::Base # :nodoc:
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      desc <<DESC
Description:
    Copies PerdiosValidator configuration file to your application's initializer directory.
DESC
      def copy_config_file
        template 'periods_validator_config.rb', 'config/initializers/periods_validator_config.rb'
      end
    end
  end
end
