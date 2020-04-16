# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :check_device

  private

  def check_device
    return if cookies.encrypted[:device_id].present?

    device = Device.create!
    cookies.encrypted[:device_id] = device.id
  end
end
