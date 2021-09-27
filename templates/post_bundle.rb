# frozen_string_literal: true

# FILE_URL = 'https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/files'

FILE_URL = '/Users/ryan/Code/ryanstrickler/rails-6-application-templates/files'

def remove_file(filename)
  run "rm #{filename}"
end

def add_file(filename)
  file filename, URI.open("#{FILE_URL}/#{filename}").read
end

def replace_file(filename)
  remove_file(filename)
  add_file(filename)
end

# rubocop:disable Style/ClassVars
class MigrationNamer
  def initialize(filename)
    @@timestamp = Time.now.utc.strftime('%Y%m%d%H%M%S').to_i
    @original_filename = filename
    @unique_filename_section = extract_unique_filename_section(filename)
  end

  def new_filename
    "db/migrate/#{new_timestamp}_#{@unique_filename_section}"
  end

  private

  def extract_unique_filename_section(filename)
    filename_only = filename.gsub('db/migrate/', '') # 'YYYYMMDDHHMMSS_create_people.rb'
    parts = filename_only.split('_') # ['YYYYMMDDHHMMSS', 'create', 'people.rb']
    parts_minus_timestamp = parts.drop(1) # ['create', 'people.rb']
    parts_minus_timestamp.join('_') # 'create_people.rb'
  end

  def new_timestamp
    @@timestamp += 1
    @@timestamp.to_s
  end
end
# rubocop:enable Style/ClassVars

def add_migration(filename)
  renamer = MigrationNamer.new(filename)
  file renamer.new_filename, open("#{FILE_URL}/#{filename}").read
  sleep(1) # Wait a second to make sure the migration names don't conflict.
end

# Add home page.
replace_file('config/routes.rb')
add_file 'app/controllers/home_controller.rb'
add_file 'app/helpers/home_helper.rb'
add_file 'app/views/home/_device_count.html.erb'
add_file 'app/views/home/_status.html.erb'
add_file 'app/views/home/index.html.erb'
add_file 'test/controllers/home_controller_test.rb'

# Add device model.
add_file 'app/models/device.rb'
add_migration 'db/migrate/20200410230315_create_devices.rb'
add_file 'test/fixtures/devices.yml'
add_file 'test/models/device_test.rb'
replace_file 'app/controllers/application_controller.rb'

# Add person model.
add_file 'app/models/person.rb'
add_migration 'db/migrate/20200409155616_create_people.rb'
add_file 'test/fixtures/people.yml'
add_file 'test/models/person_test.rb'

# Set up test helper.
replace_file 'test/test_helper.rb'

# Test mailers.
add_file 'app/mailers/person_mailer.rb'
add_file 'app/views/person_mailer/test.html.erb'
add_file 'test/mailers/person_mailer_test.rb'
add_file 'test/mailers/previews/person_mailer_preview.rb'

# Test jobs.
add_file 'test/jobs/test_job_test.rb'
add_file 'app/jobs/test_job.rb'

# Test websockets.
replace_file 'test/channels/application_cable/connection_test.rb'
replace_file 'app/channels/application_cable/connection.rb'
add_file 'app/channels/test_channel.rb'
add_file 'app/javascript/channels/test_channel.js'
add_file 'test/channels/test_channel_test.rb'

# Test system.
add_file 'test/system/load_home_test.rb'

# Set up linting.
add_file '.rubocop.yml'

# Set up Heroku processes.
add_file 'Procfile'
add_file 'config/clock.rb'
add_file 'config/initializers/sidekiq.rb'
add_file 'config/sidekiq.yml'

# Set up generators.
add_file 'config/initializers/generators.rb'

# Set up other configurations.
add_file 'config/initializers/nilify_blanks.rb'
