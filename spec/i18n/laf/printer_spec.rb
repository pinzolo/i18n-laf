# coding: utf-8
require "spec_helper"
require "i18n/laf/printer"
require "stringio"

def capture(stream)
  begin
    stream = stream.to_s
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  ensure
    eval "$#{stream} = #{stream.upcase}"
  end
  result
end

describe I18n::LaF::Printer do
  let(:locale_path) { File.expand_path(File.join(File.dirname(__FILE__), "../../../data/tree")) }

  describe "#print" do
    context "when lost item not exist" do
      let(:office) { I18n::LaF::Office.new(File.join(locale_path, "model/user")) }

      it "output information of lost items" do
        output = capture(:stdout) do
          office.work!
          I18n::LaF::Printer.new(office).print
        end
        expected =<<_EOS_
Home directory: #{File.join(locale_path, "model/user")}
Locales: de, en, ja
============
There is no lost item, Yeah!
_EOS_
        expect(output).to eq expected
      end
    end

    context "when lost items exist" do
      let(:office) { I18n::LaF::Office.new(File.join(locale_path, "model/book")) }

      it "output information of lost items" do
        output = capture(:stdout) do
          office.work!
          I18n::LaF::Printer.new(office).print
        end
        expected =<<_EOS_
Home directory: #{File.join(locale_path, "model/book")}
Locales: de, en, ja
============
de => {
  models.book.author
  models.book.price
}
en => {
  models.book.author
}
ja => {
  models.book.title
}
_EOS_
        expect(output).to eq expected
      end
    end
  end
end
