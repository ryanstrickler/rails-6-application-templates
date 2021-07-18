#!/bin/bash

# Usage:
# bash <(curl -Ls https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/scripts/new-project.sh)

gem update rails

echo What is the name of your new Rails app?
read app_name

rails new $app_name -d postgresql --webpack=stimulus
cd $app_name

# rails app:template LOCATION=https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/pre_bundle.rb

rails app:template LOCATION=/Users/ryan/Code/ryanstrickler/rails-6-application-templates/templates/pre_bundle.rb

bundle

# rails app:template LOCATION=https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/post_bundle.rb

rails app:template LOCATION=/Users/ryan/Code/ryanstrickler/rails-6-application-templates/templates/post_bundle.rb

# yarn add tailwindcss
# using PostCSS 7 compatibility build
# https://tailwindcss.com/docs/installation#post-css-7-compatibility-build
yarn add tailwindcss@npm:@tailwindcss/postcss7-compat postcss@^7 autoprefixer@^9 @tailwindcss/forms @tailwindcss/typography @tailwindcss/aspect-ratio

npx tailwindcss init

# rails app:template LOCATION=https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/tailwind.rb

rails app:template LOCATION=/Users/ryan/Code/ryanstrickler/rails-6-application-templates/templates/tailwind.rb

yarn add @tailwindcss/ui

# rails app:template LOCATION=https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/templates/tailwind_plus_ui.rb

# TODO: rework this
# rails app:template LOCATION=/Users/ryan/Code/ryanstrickler/rails-6-application-templates/templates/tailwind_plus_ui.rb

rails db:create
rails db:migrate

echo '' >> .gitignore
echo '# Ignore code coverage.' >> .gitignore
echo 'coverage' >> .gitignore

bundle exec rubocop -A

git init
git add '.'
git commit -a -m 'Initial commit'

bundle exec rubocop -A && bundle exec rails test:system test

code .

# export HEROKU_APP_NAME=$app_name
# while [ !heroku apps:create $HEROKU_APP_NAME ]
# do
#   echo Your app name is already taken on Heroku. Please enter another name to use.
#   read HEROKU_APP_NAME
# done

# add Heroku platform to bundle
bundle lock --add-platform x86_64-linux

heroku apps:create $app_name
heroku buildpacks:add --index 1 heroku/nodejs
heroku buildpacks:add --index 2 heroku/ruby
git push heroku master
heroku addons:create heroku-redis:hobby-dev
heroku open
