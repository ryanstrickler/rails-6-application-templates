def replace_file(filename:)
  run "rm #{filename}"
  file filename, open("https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/files/#{filename}").read
end

replace_file(filename: '.ruby-version')
