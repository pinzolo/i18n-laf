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
  let(:locale_path) { File.expand_path(File.join(File.dirname(__FILE__), "../../../locales")) }
  let(:office) { I18n::LaF::Office.new(File.join(locale_path, "flat")) }

  describe "#print" do
    context "when lost items exist"
    it "output information of lost items" do
      output = capture(:stdout) do
        office.work!
        I18n::LaF::Printer.new(office).print
      end
      expected =<<_EOS_
Home directory: #{File.join(locale_path, "flat")}
Locales: de, en, ja
============
de => {
  item2
  item3.item3-2
}
en => {
  item2
}
_EOS_
      expect(output).to eq expected
    end
  end
end
