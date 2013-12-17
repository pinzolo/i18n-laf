# coding: utf-8
require "i18n/laf/analyzer"
require "i18n/laf/chief_editor"
require "i18n/laf/finder"
require "i18n/laf/found_item"

module I18n::LaF
  class Office
    attr_reader :home, :leaves, :dictionaries, :lost_items

    def initialize(home)
      @home = home
    end

    def work!
      load_leaves!
      load_dictionaries!
      @lost_items = Finder.new(dictionaries).find_lost_items
    end

    def search(key, locale = nil)
      load_leaves!
      hits = @leaves.select { |leaf| leaf.keys.include?(key) }
      leaf = locale ? hits.find { |leaf| leaf.locale == locale } : hits.first
      leaf ? FoundItem.new(leaf.locale, key, leaf.data[key], leaf.file_path) : nil
    end

    def lost_item_for(locale)
      return nil if @lost_items.nil?
      @lost_items.find { |i| i.locale == locale }
    end

    private
    def yaml_files
      Dir.glob(File.join(@home, "**", "*.yml"))
    end

    def load_leaves!
      @leaves = yaml_files.map do |yaml_file|
        Analyzer.new(yaml_file).analyze
      end
    end

    def load_dictionaries!
      @dictionaries = ChiefEditor.new(@leaves).edit
    end
  end
end
