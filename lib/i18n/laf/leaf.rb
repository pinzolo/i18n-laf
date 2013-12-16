# coding: utf-8
module I18n::LaF
  class Leaf
    attr_reader :locale, :keys, :data, :file_path

    def initialize(locale, data, file_path)
      @locale = locale
      @keys = data.keys if data.respond_to?(:keys)
      @data = data
      @file_path = file_path
    end
  end
end

