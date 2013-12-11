# coding: utf-8
require "i18n/laf/lost_item"

module I18n::Laf
  class Finder
    def initialize(dictionaries)
      @dictionaries = dictionaries
    end

    def find_lost_items
      @dictionaries.map do |dict|
        lost_keys = all_keys - dict.keys
        LostItem.new(dict.locale, lost_keys) unless lost_keys.empty?
      end.compact
    end

    private
    def all_keys
      @all_keys ||= @dictionaries.map(&:keys).inject(:|)
    end
  end
end
