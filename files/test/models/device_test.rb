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
