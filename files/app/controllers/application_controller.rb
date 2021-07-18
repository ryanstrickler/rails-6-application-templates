# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :load_or_create_device

  private

  def current_device
    @current_device ||= load_or_create_device
  end

  def load_or_create_device
    load_device || create_device
  end

  def load_device
    return if cookies.encrypted[:device_id].blank?

    @current_device = Device.find_by(id: cookies.encrypted[:device_id])
  end

  def create_device
    @current_device = Device.create!
    cookies.encrypted[:device_id] = @current_device.id
    @current_device
  end
end
