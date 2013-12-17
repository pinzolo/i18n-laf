# coding: utf-8
module I18n::LaF
  class FoundItem
    attr_reader :locale, :key, :value, :file_path

    def initialize(locale, key, value, file_path)
      @locale, @key, @value, @file_path = locale, key, value, file_path
    end

    def to_s
      key_elements = @key.split(".")
      strs = ["#{@locale}:"]
      indent = "  "
      indent_level = 1
      key_elements.each do |elm|
        strs << "#{indent * indent_level}#{elm}:"
        indent_level += 1
      end
      strs.last << " #{@value}"
      strs << "in #{@file_path}"
      strs.join("\n")
    end
  end
end

