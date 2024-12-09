require 'rspec'
require 'csv'
require_relative '../src/logs_stats'
require_relative '../src/flow_log_entry'

class MockLogReader
    def initialize(entries)
        @entries = entries
    end

    def each_log_entry
        @entries.each { |entry| yield entry }
    end
end

class MockLogTagger
    def tag_log_entry(log_entry)
        log_entry.tag = 'mock_tag'
    end
end

RSpec.describe LogStats do
    let(:log_entries) do
        [
            FlowLogEntry.new(["2", "123456789012", "eni-12345", "192.168.0.1", "192.168.0.2", "12345", "80", "6", "10", "500", "1622471122", "1622471182", "ACCEPT", "OK"]),
            FlowLogEntry.new(["2", "123456789012", "eni-12345", "192.168.0.1", "192.168.0.2", "12345", "80", "6", "10", "500", "1622471122", "1622471182", "ACCEPT", "OK"])
        ]
    end
    let(:log_reader) { MockLogReader.new(log_entries) }
    let(:log_tagger) { MockLogTagger.new }
    let(:log_stats) { LogStats.new(log_reader, log_tagger) }


    describe '#save_stats' do
        it 'saves both tag stats and port protocol counts to CSV files' do
            log_stats.save_stats('test_tag_stats.csv', 'test_port_protocol_counts.csv')
            expect(File.read('test_tag_stats.csv')).to eq("Tag,Count\nmock_tag,2\n")
            expect(File.read('test_port_protocol_counts.csv')).to eq("Port,Protocol,Count\n80,tcp,2\n")
            File.delete('test_tag_stats.csv')
            File.delete('test_port_protocol_counts.csv')
        end
    end
end