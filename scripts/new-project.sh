#!/bin/bash

# Usage:
# bash <(curl -Ls https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/scripts/new-project.sh)

echo What is the name of your new Rails app?
read app_name

rails new $app_name -d postgresql --webpack=stimulus
cd $app_name

rails app:template LOCATION=https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/ruby-version.rb
rails app:template LOCATION=https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/gemfile.rb
bundle

git init
git add '.'
git commit -a -m 'Initial commit'

cd ..
mv $app_name rails
cd rails

atom .
