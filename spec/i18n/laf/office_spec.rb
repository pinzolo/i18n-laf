# coding: utf-8
require "spec_helper"

describe I18n::LaF::Office do
  let(:locale_path) { File.expand_path(File.join(File.dirname(__FILE__), "../../../locales")) }

  context "when target files are placed flat" do
    let(:office) { I18n::LaF::Office.new(File.join(locale_path, "flat")) }

    describe "#home" do
      it "returns given path" do
        expect(office.home).to eq File.join(locale_path, "flat")
      end
    end

    describe "#dictionaries" do
      before { office.work! }

      it "returns 3 items" do
        expect(office.dictionaries).to have(3).items
      end
      it "returns I18n::LaF::Dictionary instances" do
        expect(office.dictionaries.all? { |dic| dic.is_a?(I18n::LaF::Dictionary) }).to eq true
      end
      it "these locales are [ja, en, de]" do
        expect(office.dictionaries.map(&:locale)).to match_array ["ja", "en", "de"]
      end
      it "these have flat keys" do
        dict_ja = office.dictionaries.find { |d| d.locale == "ja" }
        expect(dict_ja.keys).to match_array %w(item1 item2 item3.item3-1 item3.item3-2 item4)
      end
    end
    describe "#lost_items" do
      before { office.work! }

      it "returns 2 items" do
        expect(office.lost_items).to have(2).items
      end
      it "returns I18n::LaF::LostItem instances" do
        expect(office.lost_items.all? { |dic| dic.is_a?(I18n::LaF::LostItem) }).to eq true
      end
      it "these locales are [en, de]" do
        expect(office.lost_items.map(&:locale)).to match_array ["en", "de"]
      end
      it "lost items in en has 1 key that is item2" do
        lost_item = office.lost_items.find { |l| l.locale == "en" }
        expect(lost_item.keys).to match_array ["item2"]
      end
      it "lost items in de has 2 keys that are item2 and item3.item3-2" do
        lost_item = office.lost_items.find { |l| l.locale == "de" }
        expect(lost_item.keys).to match_array ["item2", "item3.item3-2"]
      end
    end
  end
end
