require 'clockwork'
require 'active_support/time' # Allow numeric durations (eg: 1.minutes)

# Include environment to access job classes.
require './config/boot'
require './config/environment'

module Clockwork
  # handler do |job|
  #   puts "Running #{job}"
  # end

  # handler do |job, time|
  #   puts "Running #{job}, at #{time}"
  # end

  every(1.minute, 'test task') do
    TestJob.perform_later
  end

  # every(1.hour, 'hourly tasks: on the hour', at: '**:00') do
  # end

  # every 1.day, 'daily tasks: morning', at: '16:00' do # US Central Time
  # end

  # every 1.day, 'daily tasks: off-hours', at: '08:00' do # US Central Time
  # end
end
