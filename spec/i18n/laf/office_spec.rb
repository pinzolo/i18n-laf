# coding: utf-8
require "spec_helper"

describe I18n::LaF::Office do
  let(:locale_path) { File.expand_path(File.join(File.dirname(__FILE__), "../../../data/tree")) }

  shared_examples_for "having dictionaries" do
    it "returns 3 items" do
      expect(office.dictionaries).to have(3).items
    end
    it "returns I18n::LaF::Dictionary instances" do
      expect(office.dictionaries.all? { |dic| dic.is_a?(I18n::LaF::Dictionary) }).to eq true
    end
    it "these locales are [ja, en, de]" do
      expect(office.dictionaries.map(&:locale)).to match_array ["ja", "en", "de"]
    end
  end

  shared_examples_for "having lost items" do
    it "returns 3 items" do
      expect(office.lost_items).to have(3).items
    end
    it "returns I18n::LaF::LostItem instances" do
      expect(office.lost_items.all? { |dic| dic.is_a?(I18n::LaF::LostItem) }).to eq true
    end
    it "these locales are [ja, en, de]" do
      expect(office.lost_items.map(&:locale)).to match_array ["ja", "en", "de"]
    end
  end

  describe "lost item finding" do
    context "when target files have no lost key" do
      let(:office) { I18n::LaF::Office.new(File.join(locale_path, "model/user")) }
      before { office.work! }

      it_should_behave_like "having dictionaries"

      describe "#lost_items" do
        it "returns empty" do
          expect(office.lost_items).to be_empty
        end
      end
    end

    context "when target is empty directory" do
      let(:office) { I18n::LaF::Office.new(File.join(locale_path, "view/users")) }
      before { office.work! }

      describe "#leaves" do
        it "returns empty" do
          expect(office.leaves).to be_empty
        end
      end

      describe "#dictionaries" do
        it "returns empty" do
          expect(office.dictionaries).to be_empty
        end
      end

      describe "#lost_items" do
        it "returns empty" do
          expect(office.lost_items).to be_empty
        end
      end
    end

    context "when target files are placed flat" do
      let(:office) { I18n::LaF::Office.new(File.join(locale_path, "model/book")) }
      before { office.work! }

      describe "#home" do
        it "returns given path" do
          expect(office.home).to eq File.join(locale_path, "model/book")
        end
      end

      describe "#dictionaries" do
        it_should_behave_like "having dictionaries"

        it "these have flat keys" do
          dict_ja = office.dictionaries.find { |d| d.locale == "ja" }
          expect(dict_ja.keys).to match_array %w(models.book.author models.book.price)
        end
      end

      describe "#lost_item_for" do
        it "returns lost item in given locale if exists" do
          lost_item = office.lost_item_for("ja")
          expect(lost_item).not_to be_nil
        end
        it "returns nil in given locale if not exists" do
          lost_item = office.lost_item_for("fr")
          expect(lost_item).to be_nil
        end
        it "returns I18n::LaF::LostItem instance" do
          lost_item = office.lost_item_for("ja")
          expect(lost_item).to be_a(I18n::LaF::LostItem)
        end
      end

      describe "#lost_items" do
        it_should_behave_like "having lost items"

        it "lost items in ja has 1 key that is title" do
          expect(office.lost_item_for("ja").keys).to match_array ["models.book.title"]
        end
        it "lost items in en has 1 key that is author" do
          expect(office.lost_item_for("en").keys).to match_array ["models.book.author"]
        end
        it "lost items in de has 2 keys that are author and price" do
          expect(office.lost_item_for("de").keys).to match_array %w(models.book.author models.book.price)
        end
      end
    end

    context "when target files are placed in multi directory" do
      let(:office) { I18n::LaF::Office.new(locale_path) }
      before { office.work! }

      it_should_behave_like "having dictionaries"

      describe "#lost_items" do
        it_should_behave_like "having lost items"

        it "lost items in ja has 1 key that is models.book.title" do
          expect(office.lost_item_for("ja").keys).to match_array ["models.book.title"]
        end
        it "lost items in en has 1 key that is models.book.author" do
          expect(office.lost_item_for("en").keys).to match_array ["models.book.author"]
        end
        it "lost items in de has 4 keys that are models.book.author, models.book.price, views.books.title and views.books.caution" do
          expect(office.lost_item_for("de").keys).to match_array %w(models.book.author models.book.price views.books.title views.books.caution)
        end
      end
    end
  end
end
