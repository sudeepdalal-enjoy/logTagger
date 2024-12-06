class FlowLogEntry
    ATTRIBUTES = [
        :version, :account_id, :interface_id, :srcaddr, :dstaddr,
        :srcport, :dstport, :protocol, :packets, :bytes, :start,
        :end, :action, :log_status
    ]

    attr_accessor(*ATTRIBUTES)

    def initialize(fields)
        ATTRIBUTES.each_with_index do |attr, index|
            value = fields[index]
            value = value.to_i if [:srcport, :dstport, :protocol, :packets, :bytes, :start, :end].include?(attr)
            instance_variable_set("@#{attr}", value)
        end
    end

    def self.parse(log_line)
        fields = log_line.strip.split
        new(fields)
    end
end


