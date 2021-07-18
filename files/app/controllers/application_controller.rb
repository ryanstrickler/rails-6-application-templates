# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :load_or_create_device

  private

  def load_or_create_device
    @current_device = Device.find_or_create_by!(
      id: cookies.encrypted[:device_id]
    )
    cookies.encrypted[:device_id] = @current_device.id
  end
end
