# coding: utf-8
require "yaml"
require "i18n/laf/dictionary"

module I18n::LaF
  class Analyzer
    def initialize(yaml_file)
      @yaml_file = yaml_file
    end

    def analyze
      locale = extract_locale(yaml_file)
      Dictionary.new(locale, flatten(extract_data(yaml_file, locale)))
    end

    private
    def flatten(data, base_key = nil)
      data.each_with_object({}) do |(k, v), dict|
        key = base_key ? "#{base_key}.#{k}" : k.to_s
        dict.merge!(v.is_a?(Hash) ? keys(v, key) : { key => v })
      end
    end

    def extract_locale(yaml_file)
      File.basename(yaml_file, ".*")
    end

    def extract_data(yaml_file, locale)
      YAML.load_file(yml_path)[locale]
    end
  end
end
