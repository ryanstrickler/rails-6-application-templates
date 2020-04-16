require "test_helper"

class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
  setup do
    @device = devices(:one)
    @device.update!(id: 123)
  end

  test "connects with cookies" do
    cookies.encrypted[:device_id] = @device.id

    connect
    assert_equal 123, connection.current_device.id

    disconnect
    assert_nil connection
  end

  test 'fails connection with bad token' do
    cookies.encrypted[:device_id] = -1

    assert_reject_connection { connect }
    assert_nil connection
  end

  test 'fails connection with nil token' do
    cookies.encrypted[:device_id] = nil

    assert_reject_connection { connect }
    assert_nil connection
  end

  test 'fails connection with no token' do
    assert_reject_connection { connect }
    assert_nil connection
  end
end
