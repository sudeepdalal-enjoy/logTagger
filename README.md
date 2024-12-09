- Following project create tags and port protocol stats for VPC logflow V2 data as per lookup table defined at ./src/script/data/lookup_table.csv

- Only dependency mentioned in Gemfile is rspec for running tests
- How to run tests

    `bundle && rspec`
- Execute as script

    `./src/script/tag_and_count`
    
- output location

    ./src/script/output/tag_stats.csv and ./src/script/output/port_protocol_counts.csv
