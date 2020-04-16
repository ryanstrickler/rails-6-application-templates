# frozen_string_literal: true

FILE_URL = 'https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/files'

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
end

# Add root page.
replace_file('config/routes.rb')
add_file 'app/controllers/root_controller.rb'
add_file 'app/helpers/root_helper.rb'
add_file 'app/views/root/_device_count.html.slim'
add_file 'app/views/root/_status.html.slim'
add_file 'app/views/root/index.html.slim'
add_file 'test/controllers/root_controller_test.rb'

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
add_file 'app/views/person_mailer/test.html.slim'
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
add_file 'test/system/load_root_test.rb'

# Set up linting.
add_file '.rubocop.yml'
