run 'rm .ruby-version'
file '.ruby-version', <<-CODE
  2.7.0
CODE

run 'rm Gemfile'
run 'rm Gemfile.lock'
file 'Gemfile', <<-CODE
  source 'https://rubygems.org'

  ruby '2.7.0'

  gem 'rails', '6.0.2.1'

  gem 'bcrypt'
  gem 'image_processing'
  gem 'bootsnap', require: false
  gem 'pg'
  gem 'puma'
  gem 'redis'
  gem 'sass-rails'
  gem 'turbolinks'
  gem 'webpacker'
  gem 'jbuilder'

  group :development, :test do
    gem 'byebug'
  end

  group :development do
    gem 'listen'
    gem 'spring-watcher-listen'
    gem 'spring'
    gem 'web-console'
  end

  group :test do
    gem 'capybara'
    gem 'selenium-webdriver'
    gem 'webdrivers'
  end
CODE
