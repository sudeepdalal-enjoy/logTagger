require 'rspec'
require_relative '../src/flow_log_entry'

RSpec.describe FlowLogEntry do
  let(:log_line) { "2 123456789012 eni-12345 192.168.0.1 192.168.0.2 12345 80 6 10 500 1622471122 1622471182 ACCEPT OK" }
  let(:fields) { log_line.split }
  let(:entry) { FlowLogEntry.new(fields) }
  it 'creates a new FlowLogEntry' do
    entry = FlowLogEntry.new(fields)
    expect(entry).to be_an_instance_of(FlowLogEntry)
  end
  
  it 'has a valid attribute' do
    entry = FlowLogEntry.new(fields)
    expect(entry.instance_variables).to eq(FlowLogEntry::ATTRIBUTES.map { |attr| "@#{attr}".to_sym })
  end
end
RSpec.describe FlowLogEntry do
    let(:log_line) { "2 123456789012 eni-12345 192.168.0.1 192.168.0.2 12345 80 6 10 500 1622471122 1622471182 ACCEPT OK" }
    let(:fields) { log_line.split }
    let(:entry) { FlowLogEntry.new(fields) }

    it 'parses a log line correctly' do
        parsed_entry = FlowLogEntry.parse(log_line)
        expect(parsed_entry).to be_an_instance_of(FlowLogEntry)
        expect(parsed_entry.version).to eq("2")
        expect(parsed_entry.account_id).to eq("123456789012")
        expect(parsed_entry.interface_id).to eq("eni-12345")
        expect(parsed_entry.srcaddr).to eq("192.168.0.1")
        expect(parsed_entry.dstaddr).to eq("192.168.0.2")
        expect(parsed_entry.srcport).to eq(12345)
        expect(parsed_entry.dstport).to eq(80)
        expect(parsed_entry.protocol).to eq(6)
        expect(parsed_entry.packets).to eq(10)
        expect(parsed_entry.bytes).to eq(500)
        expect(parsed_entry.start).to eq(1622471122)
        expect(parsed_entry.end).to eq(1622471182)
        expect(parsed_entry.action).to eq("ACCEPT")
        expect(parsed_entry.log_status).to eq("OK")
    end

    it 'initializes attributes correctly' do
        expect(entry.version).to eq("2")
        expect(entry.account_id).to eq("123456789012")
        expect(entry.interface_id).to eq("eni-12345")
        expect(entry.srcaddr).to eq("192.168.0.1")
        expect(entry.dstaddr).to eq("192.168.0.2")
        expect(entry.srcport).to eq(12345)
        expect(entry.dstport).to eq(80)
        expect(entry.protocol).to eq(6)
        expect(entry.packets).to eq(10)
        expect(entry.bytes).to eq(500)
        expect(entry.start).to eq(1622471122)
        expect(entry.end).to eq(1622471182)
        expect(entry.action).to eq("ACCEPT")
        expect(entry.log_status).to eq("OK")
    end
end