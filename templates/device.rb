FORMAT = '%Y%m%d%H%M%S'

file 'app/models/device.rb', <<~CODE.strip_heredoc
  class Device < ApplicationRecord
    has_secure_token

    validates :token, presence: true
  end
CODE

file "db/migrate/#{Time.now.utc.strftime(FORMAT)}_create_devices.rb", <<~CODE.strip_heredoc
  class CreateDevices < ActiveRecord::Migration[6.0]
    def change
      create_table :devices do |t|
        t.string :token, null: false

        t.timestamps
      end
    end
  end
CODE

file 'test/fixtures/devices.yml', <<~CODE.strip_heredoc
  one:
    token: <%= SecureRandom.hex %>
  two:
    token: <%= SecureRandom.hex %>
CODE

file 'test/models/device_test.rb', <<~CODE.strip_heredoc
  require 'test_helper'

  class DeviceTest < ActiveSupport::TestCase
    setup do
      @device = devices(:one)
    end

    describe 'validations' do
      test 'token required' do
        @device.token = nil
        refute @device.valid?
      end
    end
  end
CODE
