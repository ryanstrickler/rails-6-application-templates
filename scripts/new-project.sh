#!/bin/bash

# Usage:
# bash <(curl -Ls https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/scripts/new-project.sh)

echo What is the name of your new Rails app?
read app_name

rails new $app_name -d postgresql --webpack=stimulus
cd $app_name

rails app:template LOCATION=https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/gemfile.rb
rails app:template LOCATION=https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/root.rb
rails app:template LOCATION=https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/test_helper.rb
rails app:template LOCATION=https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/jobs.rb
rails app:template LOCATION=https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/person.rb
rails app:template LOCATION=https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/person_mailer.rb
rails app:template LOCATION=https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/device.rb
rails app:template LOCATION=https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/connection.rb
rails app:template LOCATION=https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/channels.rb

bundle

rails db:create
rails db:migrate

echo '' >> .gitignore
echo '# Ignore code coverage.' >> .gitignore
echo 'coverage' >> .gitignore

git init
git add '.'
git commit -a -m 'Initial commit'

cd ..
mv $app_name rails
cd rails

atom .
