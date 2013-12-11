# coding: utf-8
module I18n::LaF
  class Printer
    def initialize(office)
      @office = office
    end

    def print
      print_home
      puts
      print_locales
      puts
      print_lost_items
    end

    private
    def print_home
      puts "Home directory: #{@office.home}"
    end

    def print_locales
      tag = @office.dictionaries.size == 1 ? "Locale" : "Locales"
      puts "#{tag}: #{@office.dictionaries.map(&:locale).join(", ")}"
    end

    def print_lost_items
      if @office.lost_items.is_a?(Array) && !@office.lost_items.empty?
        puts "Lost items:"
        puts "============"
        puts @office.lost_items.map(&:to_s).join("\n")
      else
        puts "There is no lost item, Yeah!"
      end
    end
  end
end
