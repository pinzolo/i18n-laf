require "i18n/laf/office"

namespace :i18n do
  namespace :laf do
    desc "find lost items in your locale files"
    task :lost => :environment do
      if ARGV[1]
        home = ARGV[1]
      elsif defind?(Rails) && Rails.respond_to?(:root)
        home = File.join(Rails.root, "config", "locales")
      else
        puts "You must specifiy a directory path"
        return
      end
      office = I18n::LaF::Office.new(home)
      office.work!
      I18n::LaF::Printer.new.print(office)
    end

    desc "find sample by given key"
    task :found => :environment do
      if ARGV[1]
        key = ARGV[1]
      else
        puts "You must specifiy a key"
        return
      end
      if ARGV[2]
        home = ARGV[2]
      elsif defind?(Rails) && Rails.respond_to?(:root)
        home = File.join(Rails.root, "config", "locales")
      else
        puts "You must specifiy a directory path"
        return
      end
      office = I18n::LaF::Office.new(home)
      found_item = office.search(key, ARGV[3])
    end
  end
end
