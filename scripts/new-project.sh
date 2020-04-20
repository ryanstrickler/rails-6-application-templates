#!/bin/bash

# Usage:
# bash <(curl -Ls https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/scripts/new-project.sh)

echo What is the name of your new Rails app?
read app_name

rails new $app_name -d postgresql --webpack=stimulus
cd $app_name

rails app:template LOCATION=https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/pre_bundle.rb

bundle

rails app:template LOCATION=https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/post_bundle.rb

rails db:create
rails db:migrate

echo '' >> .gitignore
echo '# Ignore code coverage.' >> .gitignore
echo 'coverage' >> .gitignore

bundle exec rubocop -a

git init
git add '.'
git commit -a -m 'Initial commit'

bundle exec rubocop -a && bundle exec rails test:system test

atom .

heroku apps:create $app_name
heroku buildpacks:add --index 1 heroku/nodejs
heroku buildpacks:add --index 2 heroku/ruby
git push --set-upstream heroku master
heroku addons:create heroku-redis:hobby-dev

heroku open
