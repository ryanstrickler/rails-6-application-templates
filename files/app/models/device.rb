# frozen_string_literal: true

class Device < ApplicationRecord
  enum status: {
    connected: 'connected',
    disconnected: 'disconnected'
  }

  after_save_commit :broadcast_connected_count

  private

  def broadcast_connected_count
    device_count = ApplicationController.render(
      partial: 'root/device_count'
    )

    TestChannel.broadcast_to 'all', deviceCount: device_count
  end
end
