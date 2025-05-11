# frozen_string_literal: true

# Generates specified number of Parts (default 10) for each company in the DB.

company_count = Company.all.count

if company_count < 1
  puts 'No companies yet, please create one before proceeding'
  return
end

puts 'Interactive seeder, type skip to run with defaults. Leave answers blank for defaults.'

# Initialize defaults
should_skip = false
count = 10
all_flag = true
company_ids = []

unless should_skip
  puts "\nHow many Parts per company? (10)"
  input = $stdin.gets.chomp

  if input.to_s.downcase == 'skip'
    should_skip = true
  else
    count = input.empty? ? 10 : input.to_i

    # Add warning if part count is high
    if count > 500 && !should_skip
      puts "WARNING: You're about to create #{count} parts per company, which might take a long time. Proceed? (Y\\n)"
      proceed_input = $stdin.gets.chomp.to_s.upcase

      if proceed_input.to_s.downcase == 'skip'
        should_skip = true
      else
        should_proceed = proceed_input.empty? || proceed_input == 'Y'
        return unless should_proceed
      end
    end
  end
end

unless should_skip
  puts "\nCreate for all companies? (Y\\n)"
  input = $stdin.gets.chomp.to_s.upcase

  if input.to_s.downcase == 'skip'
    should_skip = true
  else
    all_flag = input.empty? || input == 'Y'
  end
end

if all_flag
  if company_count >= 50 && !should_skip
    puts "WARNING: This will seed #{company_count} companies, which might take a long time. Proceed? (Y\\n)"
    proceed_input = $stdin.gets.chomp.to_s.upcase

    if proceed_input.to_s.downcase == 'skip'
      true
    else
      should_proceed = proceed_input.empty? || proceed_input == 'Y'
      return unless should_proceed
    end
  end

  puts "\nSeeding #{company_count} companies with #{count} parts each"
  companies = Company.all
else
  unless should_skip
    puts 'Which companies? Pass company ids delimited by space (e.g 1 2 3 4)'
    input = $stdin.gets.chomp

    company_ids = if input.to_s.downcase == 'skip'
                    Company.all.pluck(:id)
                  else
                    input.split.map(&:to_i)
                  end
  end

  if company_ids.empty?
    puts 'No company IDs provided. Using all companies.'
    companies = Company.all
  else
    puts "\nSeeding #{company_ids.count} companies with #{count} parts each"
    companies = Company.where(id: company_ids)
  end
end

# Actual seeding logic
processed_count = 0
total_parts = 0

companies.find_each do |company|
  puts "\n\nCreating #{count} parts for company: #{company.name} (ID: #{company.id})"

  progress_bar_width = 30
  print "[#{''.ljust(progress_bar_width)}] 0%"

  count.times do |index|
    part = Part.new(
      part_number: rand(0..4).to_s + Faker::IndustrySegments.sector.gsub(' ', '') + rand(0..10).to_s,
      description: Faker::Lorem.paragraph,
      available: rand(0..50),
      reserved: rand(0..50),
      sold: rand(0..50),
      condition: 'NE',
      min_cost: rand(0.00..5000.99),
      min_price: rand(0.00..5000.99),
      min_order: rand(0..50),
      med_cost: rand(0.00..5000.99),
      med_price: rand(0.00..5000.99),
      med_order: rand(0..50),
      max_cost: rand(0.00..5000.99),
      max_price: rand(0.00..5000.99),
      max_order: rand(0..50),
      lead_time: "#{rand(0..7)} DAYS",
      quote_type: 'OUTRIGHT SALE',
      tag: Faker::Lorem.paragraph,
      company:
    )

    puts part.errors.full_messages unless part.save

    # Update progress bar
    percent_complete = ((index + 1).to_f / count * 100).round
    completed_chars = (percent_complete * progress_bar_width / 100).round
    progress_bar = '=' * completed_chars
    print "\r[#{progress_bar.ljust(progress_bar_width)}] #{percent_complete}%"
    $stdout.flush # Force output to update
  end

  puts "\nCreated #{count} parts for #{company.name}"
  processed_count += 1
  total_parts += count
end

puts "\nSeeding complete! Created #{total_parts} parts across #{processed_count} companies."
