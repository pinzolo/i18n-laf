# coding: utf-8
module I18n::LaF
  class Printer
    def initialize(office)
      @office = office
    end

    def print
      if @lost_items.is_a?(Array) && !@lost_items.empty?
        puts @lost_items.map(&:to_s).join("\n")
      else
        puts "There is no lost item, Yeah!"
      end
    end
  end
end
