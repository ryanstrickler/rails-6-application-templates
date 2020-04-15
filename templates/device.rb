FORMAT = '%Y%m%d%H%M%S'

run 'rm app/controllers/application_controller.rb'
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

file "db/migrate/#{Time.now.utc.strftime(FORMAT)}_add_status_to_devices.rb", <<~CODE.strip_heredoc
  class AddStatusToDevice < ActiveRecord::Migration[6.0]
    def change
      add_column :devices, :status, :string, null: false, default: 'disconnected'
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

    describe 'callbacks' do
      describe 'after_save_commit' do
        test 'broadcasts on the test channel' do
          TestChannel.expects(:broadcast_to).once
          @device.touch
        end
      end
    end
  end
CODE
