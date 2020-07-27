# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :load_or_create_device

  private

  def load_or_create_device
    load_device
    return if @device.present?
    create_device
  end

  def load_device
    return if cookies.encrypted[:device_id].blank?
    @device = Device.find_by(id: cookies.encrypted[:device_id])
  end

  def create_device
    @device = Device.create!
    cookies.encrypted[:device_id] = @device.id
  end
end
