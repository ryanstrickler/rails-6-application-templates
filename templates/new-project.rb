app_name = ask("What is the name of this project?")

puts "rails new #{app_name} -d postgresql --webpack=stimulus"

rails_command "rails new #{app_name} -d postgresql --webpack=stimulus"
rails_command "rails app:template LOCATION=https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/ruby-version.rb"
rails_command "rails app:template LOCATION=https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/gemfile.rb"

git :init
git add: "."
git commit: "-a -m 'Initial commit'"

run "cd .."
run "mv #{app_name} rails"
