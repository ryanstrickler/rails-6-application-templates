# frozen_string_literal: true

class TestChannel < ApplicationCable::Channel
  def subscribed
    stream_for 'all'
    current_device.touch
  end

  def unsubscribed; end
end
