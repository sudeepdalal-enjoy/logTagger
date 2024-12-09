class  LogReader
    def initialize(log_file)
        @log_file = log_file
    end

    def each_log_entry
        File.open(@log_file, 'r') do |file|
            file.each_line do |line|
                fields = FlowLogEntry.parse(line)
                yield fields
            end
        end
    end
end