# coding: utf-8
require "i18n/laf/dictionary"

module I18n::LaF
  class ChiefEditor
    def initialize(dictionaries)
      @dictionaries = dictionaries
    end

    def re_edit
      @dictionaries.each_with_object({}) do |dict, data|
        base = data[dict.locale]
        data[dict.locale] = base ? Dictionary.new(dict.locale, base.data.merge(dict.data)) : dict
      end.values
    end
  end
end
