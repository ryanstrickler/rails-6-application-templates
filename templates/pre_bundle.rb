# frozen_string_literal: true

FILE_URL = 'https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/files'

def remove_file(filename)
  run "rm #{filename}"
end

def add_file(filename)
  file filename, open("#{FILE_URL}/#{filename}").read
end

def replace_file(filename)
  remove_file(filename)
  add_file(filename)
end

remove_file('.ruby-version')
remove_file('Gemfile')
remove_file('Gemfile.lock')

add_file('.ruby-version')
add_file('Gemfile')
