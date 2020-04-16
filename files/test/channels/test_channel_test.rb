require "test_helper"

class TestChannelTest < ActionCable::Channel::TestCase
  setup do
    @device = devices(:one)
    stub_connection(current_device: @device)
  end

  test "subscribes and unsubscribes" do
    subscribe
    assert subscription.confirmed?
    assert_has_stream 'test:all'

    unsubscribe
    assert_no_streams
  end

  test 'broadcast' do
    subscribe

    assert_broadcast_on('test:all', count: 2) do
      TestChannel.broadcast_to 'all', count: Device.count
    end
  end
end
