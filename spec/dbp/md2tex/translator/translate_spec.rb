require_relative '_helper'
require 'dbp/book_compiler/markdown_to_tex/translator'

module DBP::BookCompiler::MarkdownToTex
  describe Translator do
    subject { Translator.new }
    let(:reader) { StringScanner.new(input) }
    let(:writer) { StringIO.new }

    describe 'unwraps' do
      let(:input) { '<!-- \somecommand{some argument} -->' }

      it 'comments' do
        subject.translate(reader, writer)

        _(writer.string).must_equal '\somecommand{some argument}'
      end
    end
  end
end