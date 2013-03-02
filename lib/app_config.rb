require "app_config/version"
require 'hash_ext'
require 'recursive_open_struct'
require 'yaml'

class AppConfig
  class << self
    attr_reader :hash

    def hash=(hash)
      hash.deep_symbolize_keys!

      @hash = hash
      @struct = RecursiveOpenStruct.new(hash)

      unless ['test', 'development'].include?(Rails.env)
        app_name = Rails.application.class.parent_name
        puts "Initializing #{app_name} in #{Rails.env} with config:"
        puts @hash.to_yaml
      end
    end

    def method_missing(m, *args)
      @struct.send(m, *args)
    end

    def load(*config_files, &block)
      config_files.delete(:app_config)
      init_hash = {}

      config_files.each do |config_file|
        init_hash.merge!({config_file.to_s => YAML.load_file(File.join(Rails.root, 'config', "#{config_file}.yml"))[Rails.env]})
      end

      if ['test', 'development'].include?(Rails.env)
        override_settings_file_path = File.join(Rails.root, 'config', "#{Rails.env}.yml")
        init_hash.merge!(YAML.load_file(override_settings_file_path)) if File.exist?(override_settings_file_path) 
      end

      yield(init_hash.deep_symbolize_keys!) if block_given?
      self.hash = init_hash
    end
  end
end
