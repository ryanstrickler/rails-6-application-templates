file 'app/channels/test_channel.rb', <<~CODE.strip_heredoc
  class TestChannel < ApplicationCable::Channel
    def subscribed
      stream_for "all"
    end

    def unsubscribed
    end
  end
CODE

file 'app/javascript/channels/test_channel.js', <<~CODE.strip_heredoc
  import consumer from "./consumer"

  consumer.subscriptions.create("TestChannel", {
    connected() {
      this.replaceElement('test-channel-status', 'connected')
    },

    disconnected() {
      this.replaceElement('test-channel-status', 'disconnected')
    },

    received(data) {
      this.replaceElement(
        'test-channel-device-count',
        this.formatDeviceCount(data.count)
      )
    },

    replaceElement(id, content) {
      const div = document.getElementById(id)
      div.innerHTML = content
    },

    formatDeviceCount(count) {
      if (count === 1) {
        return '1 device present'
      } else {
        return count + ' devices present'
      }
    }
  });
CODE

file 'test/channels/test_channel_test.rb', <<~CODE.strip_heredoc
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
CODE
