# coding: utf-8
module I18n::LaF
  class Dictionary
    attr_reader :locale, :keys, :data

    def initialize(locale, data)
      @locale = locale
      @keys = data.keys
      @data = data
    end
  end
end
