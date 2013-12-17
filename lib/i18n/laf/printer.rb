# coding: utf-8
require "i18n/laf/office"

module I18n::LaF
  class Printer
    def initialize(obj)
      @obj = obj
    end

    def print
      if @obj.is_a?(I18n::LaF::Office)
        print_home
        print_locales
        print_lost_items
      else
        puts @obj.to_s
      end
    end

    private
    def print_home
      puts "Home directory: #{@obj.home}"
    end

    def print_locales
      puts "Locale(s): #{@obj.dictionaries.map(&:locale).sort.join(", ")}"
    end

    def print_lost_items
      puts "============"
      if @obj.lost_items.is_a?(Array) && !@obj.lost_items.empty?
        puts @obj.lost_items.sort_by(&:locale).map(&:to_s).join("\n")
      else
        puts "There is no lost item, Yeah!"
      end
    end
  end
end
