# coding: utf-8
module I18n::LaF
  class LostItem
    attr_reader :locale, :keys

    def initialize(locale, keys)
      @locale = locale
      @keys = keys
    end

    def to_s
      strs = ["#{@locale} => {"]
      delimiter = ""
      if @keys.is_a?(Array) && !@keys.empty?
        delimiter = "\n"
        strs += @keys.sort.map { |key| "  #{key}" }
      end
      strs << "}"
      strs.join(delimiter)
    end
  end
end
