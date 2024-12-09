require 'csv'
class LogStats
    def initialize(log_reader, log_tagger)
        @log_reader = log_reader
        @log_tagger = log_tagger
        @tag_stats = Hash.new(0)
        @port_protocol_counts = Hash.new(0)
    end

    def generate_stats
        @log_reader.each_log_entry do |log_entry|
            @log_tagger.tag_log_entry(log_entry)
            @tag_stats[log_entry.tag]+= 1
            key = [log_entry.dstport, log_entry.protocol]
            @port_protocol_counts[key] += 1
        end
    end

   

    def save_tag_stats(filename = 'tag_stats.csv')
        
        CSV.open(filename, 'w') do |csv|
            csv << ['Tag', 'Count']
            @tag_stats.each do |tag, count|
                csv << [tag, count]
            end
        end
    end

    def save_port_protocol_counts(filename = 'port_protocol_counts.csv')
        CSV.open(filename, 'w') do |csv|
            csv << ['Port', 'Protocol', 'Count']
            @port_protocol_counts.each do |(port, protocol), count|
                csv << [port, protocol, count]
            end
        end
    end

   private :generate_stats, :save_tag_stats, :save_port_protocol_counts


    def save_stats(tag_filename = 'tag_stats.csv', port_protocol_filename = 'port_protocol_counts.csv')
        generate_stats
        save_tag_stats(tag_filename)
        save_port_protocol_counts(port_protocol_filename)

    end
end