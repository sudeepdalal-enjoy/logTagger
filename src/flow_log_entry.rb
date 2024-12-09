class FlowLogEntry
    PROTOCOLS = {
        1 => 'ICMP',
        6 => 'TCP',
        17 => 'UDP'
        # Add more protocols as needed
    }

    ATTRIBUTES = [
        :version, :account_id, :interface_id, :srcaddr, :dstaddr,
        :srcport, :dstport, :protocol, :packets, :bytes, :start,
        :end, :action, :log_status
    ]

    attr_accessor(*ATTRIBUTES)
    attr_accessor :tag

    def initialize(fields)
        ATTRIBUTES.each_with_index do |attr, index|
            value = fields[index]
            if [:srcport, :dstport, :packets, :bytes, :start, :end].include?(attr)
                value = value.to_i
            elsif attr == :protocol
                value = PROTOCOLS[value.to_i] || value
                value.downcase!
            end
            instance_variable_set("@#{attr}", value)
        end
    end

    def self.parse(log_line)
        fields = log_line.strip.split
        new(fields)
    end
end


