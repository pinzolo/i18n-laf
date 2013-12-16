# coding: utf-8
require "yaml"
require "i18n/laf/leaf"

module I18n::LaF
  class Analyzer
    def initialize(yaml_file)
      @yaml_file = yaml_file
    end

    def analyze
      locale = extract_locale
      Leaf.new(locale, flatten(extract_data(locale)), @yaml_file)
    end

    private
    def flatten(data, base_key = nil)
      data.each_with_object({}) do |(k, v), dict|
        key = base_key ? "#{base_key}.#{k}" : k.to_s
        dict.merge!(v.is_a?(Hash) ? flatten(v, key) : { key => v })
      end
    end

    def extract_locale
      File.basename(@yaml_file, ".*")
    end

    def extract_data(locale)
      YAML.load_file(@yaml_file)[locale]
    end
  end
end
