# coding: utf-8
require "i18n/laf/analyzer"
require "i18n/laf/chief_editor"
require "i18n/laf/finder"

module I18n::LaF
  class Office
    attr_reader :home, :dictionaries, :lost_items

    def initialize(home)
      @home = home
    end

    def work!
      load_dictionaries!
      @lost_items = Finder.new(dictionaries).find_lost_items
    end

    private
    def yaml_files
      Dir.glob(File.join(@home, "**", "*.yml"))
    end

    def collect_dictionaries
      yaml_files.map do |yaml_file|
        Analyzer.new(yaml_file).analyze
      end
    end

    def load_dictionaries!
      @dictionaries ||= ChiefEditor.new(collect_dictionaries).re_edit
    end
  end
end
