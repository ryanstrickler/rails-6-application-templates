file 'test/channels/application_cable/connection_test.rb', <<~CODE.strip_heredoc
  require "test_helper"

  class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
    setup do
      @device = devices(:one)
      @device.update!(token: 'abcdef')
    end

    test "connects and disconnects with cookies" do
      cookies.encrypted[:device_token] = @device.token

      connect
      assert_equal 'abcdef', connection.current_device.token

      disconnect
      assert_nil connection
    end

    test 'fails connection' do
      cookies.encrypted[:device_token] = 'bad-token'

      assert_raises ActionCable::Connection::Authorization::UnauthorizedError do
        connect
      end

      assert_nil connection
    end
  end
CODE

file 'app/channels/application_cable/connection.rb', <<~CODE.strip_heredoc
  module ApplicationCable
    class Connection < ActionCable::Connection::Base
      identified_by :current_device

      def connect
        self.current_device = find_verified_device
        logger.info "Device connected: #{current_device.token}"
      end

      def disconnect
        return if current_device.nil?
        logger.info "Device disconnected: #{current_device.token}"
      end

      private

      def find_verified_device
        if verified_device = Device.find_by(token: cookies.encrypted[:device_token])
          verified_device
        else
          reject_unauthorized_connection
        end
      end
    end
  end
CODE
