# Deoptimized version of homework task
require_relative '_parser'
require 'pry-byebug'

$support_dir = File.expand_path('../../spec/support', __FILE__ )
$optimizations_dir = File.expand_path('../../optimizations', __FILE__ )

def work(filename)
  File.open("#{$support_dir}/result.json", 'w') do |f|
    Report.prepare(f)

    IO.foreach("#{$support_dir}/#{filename}") do |cols|
      row = cols.split(',')

      if cols.start_with?('user')
        if Parser.parsed_exists?
          Report.add_parsed(Parser.parsed_user)

          Parser.clear_cache
        end

        Parser.parse_user(row[2], row[3])
      else
        Parser.parse_session(row[3], row[4].to_i, row[5].strip)
      end
    end

    Report.add_parsed(Parser.parsed_user)

    Report.add_analyse
  end
end
