require 'pry'
class Tagger
    def initialize(lookup_table_file)
        @lookup_table = {}
        File.open(lookup_table_file, 'r') do |file|
            file.each_line do |line|
                dstport, protocol, tag = line.strip.split(',')
                @lookup_table[dstport.to_s + protocol] = tag
            end
        end
    end

    def tag_log_entry(log_entry)
        tag = @lookup_table[log_entry.dstport.to_s + log_entry.protocol.to_s]
        log_entry.tag = tag || 'Untagged'
        log_entry
    end

end