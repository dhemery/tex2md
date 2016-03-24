require_relative '../spec_helper'
require 'tex2md/commands/read_command'

require 'strscan'

describe TeX2md::ReadCommand do
  subject { TeX2md::ReadCommand.new pattern }
  let(:translator) { FakeTranslator.new }
  let(:reader) { StringScanner.new input }
  let(:writer) { StringIO.new }

  describe 'when the input has a name that matches the pattern' do
    let(:input) { 'foo123' }
    let(:pattern) { /[[:alpha:]]+/ }

    it 'consumes the name' do
      subject.execute(translator, reader, writer)

      reader.rest.must_equal '123'
    end

    it 'writes no output' do
      subject.execute(translator, reader, writer)

      writer.string.must_be_empty
    end

    describe 'tells translator to' do
      let(:translator) { MiniTest::Mock.new }
      after { translator.verify }

      it 'finish the current command and execute the named command' do
        translator.expect :finish_command, nil
        translator.expect :execute_command, nil, ['foo']

        subject.execute(translator, reader, writer)
      end
    end
  end

  describe 'when the input does not match the pattern' do
    let(:input) { '123' }
    let(:pattern) { /[[:alpha:]]+/ }

    it 'consumes no input' do
      subject.execute(translator, reader, writer)

      reader.rest.must_equal input
    end

    it 'writes no output' do
      subject.execute(translator, reader, writer)

      writer.string.must_be_empty
    end

    describe 'tells translator to' do
      let(:translator) { MiniTest::Mock.new }
      after { translator.verify }

      it 'finish the current command and execute the nil command' do
        translator.expect :finish_command, nil
        translator.expect :execute_command, nil, [nil]

        subject.execute(translator, reader, writer)
      end
    end
  end
end
