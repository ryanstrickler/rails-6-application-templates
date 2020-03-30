run 'rm Gemfile'
run 'rm Gemfile.lock'

file 'Gemfile', <<~CODE.strip_heredoc
  source 'https://rubygems.org'

  ruby '2.6.5'

  gem 'rails', '6.0.2.1'

  # gem 'bcrypt'
  gem 'bootsnap', require: false
  # gem 'image_processing'
  # gem 'jbuilder'
  gem 'pg'
  gem 'puma'
  gem 'sass-rails'
  gem 'turbolinks'
  gem 'webpacker'

  gem 'appsignal'
  gem 'clockwork'
  gem 'httparty'
  gem 'lograge'
  gem 'sidekiq'
  gem 'slim'
  gem 'stripe'

  group :development, :test do
    gem 'byebug'
  end

  group :development do
    gem 'listen'
    gem 'spring-watcher-listen'
    gem 'spring'
    gem 'web-console'

    gem 'rubocop', require: false
    gem 'rubocop-rails'
  end

  group :test do
    gem 'capybara'
    gem 'selenium-webdriver'
    gem 'webdrivers'

    gem 'minitest-spec-rails'
    gem 'mocha'
    gem 'simplecov', require: false
    gem 'webmock', require: false
  end
CODE
