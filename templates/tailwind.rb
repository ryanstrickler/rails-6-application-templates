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

replace_file('postcss.config.js')
add_file('app/javascript/stylesheets/application.scss')
replace_file('app/javascript/packs/application.js')
replace_file('app/views/layouts/application.html.erb')
