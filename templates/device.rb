FORMAT = '%Y%m%d%H%M%S'

file 'app/controllers/application_controller.rb', <<~CODE.strip_heredoc
  class ApplicationController < ActionController::Base
    before_action :check_device

    private

    def check_device
      return if cookies.encrypted[:device_id].present?
      device = Device.create!
      cookies.encrypted[:device_id] = device.id
    end
  end
CODE

file 'app/models/device.rb', <<~CODE.strip_heredoc
  class Device < ApplicationRecord
  end
CODE

file "db/migrate/#{Time.now.utc.strftime(FORMAT)}_create_devices.rb", <<~CODE.strip_heredoc
  class CreateDevices < ActiveRecord::Migration[6.0]
    def change
      create_table :devices do |t|
        t.timestamps
      end
    end
  end
CODE

file 'test/fixtures/devices.yml', <<~CODE.strip_heredoc
  one:
    id: 123
  two:
    id: 789
CODE

file 'test/models/device_test.rb', <<~CODE.strip_heredoc
  require 'test_helper'

  class DeviceTest < ActiveSupport::TestCase
    setup do
      @device = devices(:one)
    end
  end
CODE
