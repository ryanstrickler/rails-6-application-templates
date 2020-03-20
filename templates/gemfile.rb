run 'rm Gemfile'
run 'rm Gemfile.lock'
file 'Gemfile', <<~CODE.strip_heredoc
  source 'https://rubygems.org'

  ruby '2.7.0'

  gem 'rails', '6.0.2.1'

  gem 'bcrypt'
  gem 'bootsnap', require: false
  gem 'image_processing'
  gem 'jbuilder'
  gem 'pg'
  gem 'puma'
  gem 'redis'
  gem 'sass-rails'
  gem 'turbolinks'
  gem 'webpacker'

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
