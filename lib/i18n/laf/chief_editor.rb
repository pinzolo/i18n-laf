# coding: utf-8
require "i18n/laf/dictionary"

module I18n::LaF
  class ChiefEditor
    def initialize(leaves)
      @leaves = leaves
    end

    def edit
      @leaves.each_with_object({}) do |leaf, data|
        data[leaf.locale] = Dictionary.new(leaf, data[leaf.locale])
      end.values
    end
  end
end
