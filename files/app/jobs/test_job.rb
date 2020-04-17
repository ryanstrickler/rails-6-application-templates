# frozen_string_literal: true

class TestJob < ApplicationJob
  queue_as :default

  def perform
    logger.debug 'This is only a test... job.'
  end
end
