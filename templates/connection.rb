run 'rm test/channels/application_cable/connection_test.rb'
file 'test/channels/application_cable/connection_test.rb', <<~CODE.strip_heredoc
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
CODE

run 'rm app/channels/application_cable/connection.rb'
file 'app/channels/application_cable/connection.rb', <<~CODE.strip_heredoc
  module ApplicationCable
    class Connection < ActionCable::Connection::Base
      identified_by :current_device

      def connect
        self.current_device = find_verified_device
        current_device.connected!
      end

      def disconnect
        return if current_device.nil?
        current_device.disconnected!
      end

      private

      def find_verified_device
        if verified_device = Device.find_by(id: cookies.encrypted[:device_id])
          verified_device
        else
          reject_unauthorized_connection
        end
      end
    end
  end
CODE
