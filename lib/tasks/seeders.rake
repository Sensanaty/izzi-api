# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
def extract_description(filename)
  first_paragraph = []
  in_first_paragraph = false

  File.foreach(filename) do |line|
    line = line.strip

    # Skip frozen string literal line
    next if line == '# frozen_string_literal: true'

    # Start collecting comment lines for the first paragraph
    if line.start_with?('#')
      in_first_paragraph = true
      first_paragraph << line[1..].strip
    elsif line.empty? && in_first_paragraph
      break
    end
  end

  first_paragraph.empty? ? 'Custom seeder' : first_paragraph.join(' ')
end
# rubocop:enable Metrics/MethodLength

namespace :db do
  namespace :seed do
    Dir[Rails.root.join('db', 'seeders', '*.rb')].each do |filename|
      task_name = File.basename(filename, '.rb')

      desc extract_description(filename)

      task task_name.to_sym => :environment do
        load(filename) if File.exist?(filename)
      end
    end
  end
end
