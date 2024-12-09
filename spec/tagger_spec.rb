require 'rspec'
require_relative '../src/tagger'
require_relative '../src/flow_log_entry'
require 'pry'

RSpec.describe Tagger do
  let(:lookup_table_file) { 'spec/fixtures/lookup_table.csv' }
  let(:tagger) { Tagger.new(lookup_table_file) }

  describe '#initialize' do
    it 'loads the lookup table from the file' do
        expect(tagger.instance_variable_get(:@lookup_table)).to eq({
            '80tcp' => 'Web',
            '443tcp' => 'SecureWeb',
            '53udp' => 'DNS',
        })
    end
  end

  describe '#tag_log_entry' do
    it 'tags a log entry based on the lookup table' do
      log_entry = FlowLogEntry.new([nil, nil, nil, nil, nil, nil, 80, 6, nil, nil, nil, nil, nil, nil])
      tagged_entry = tagger.tag_log_entry(log_entry)
      
      expect(tagged_entry.tag).to eq('Web')
    end

    it 'tags a log entry as "Untagged" if no match is found' do
      log_entry = FlowLogEntry.new([nil, nil, nil, nil, nil, nil, 1234, 6, nil, nil, nil, nil, nil, nil])
      tagged_entry = tagger.tag_log_entry(log_entry)
      expect(tagged_entry.tag).to eq('Untagged')
    end
  end
end