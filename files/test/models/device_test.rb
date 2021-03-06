# frozen_string_literal: true

require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  setup do
    @device = devices(:one)
  end

  describe 'fixture' do
    test 'valid as generated' do
      assert @device.valid?
    end
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
