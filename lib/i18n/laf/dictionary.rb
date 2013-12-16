# coding: utf-8
module I18n::LaF
  class Dictionary
    attr_reader :locale, :leaves

    def initialize(leaf, base = nil)
      @locale = leaf.locale
      @leaves = base ? base.leaves + [leaf] : [leaf]
    end

    def keys
      @keys ||= @leaves.inject([]) { |keys, leaf| keys + leaf.keys }
    end

    def data
      @data ||= @leaves.inject({}) { |data, leaf| data.merge(leaf.data) }
    end
  end
end
