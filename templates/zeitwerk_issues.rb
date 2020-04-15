# Not using this currently.

file 'config/initializers/zeitwerk.rb', <<~'CODE'.strip_heredoc
  return unless Rails.env.test?

  Rails.application.config.autoloader = :classic
CODE
