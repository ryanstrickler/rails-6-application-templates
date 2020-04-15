run 'rm config/routes.rb'
file 'config/routes.rb', <<~'CODE'.strip_heredoc
  Rails.application.routes.draw do
    root to: 'root#index'
  end
CODE

file 'app/controllers/root_controller.rb', <<~'CODE'.strip_heredoc
  class RootController < ApplicationController
    def index; end
  end
CODE

file 'app/helpers/root_helper.rb', <<~'CODE'.strip_heredoc
  module RootHelper
    def test_helper(content:)
      content
    end
  end
CODE

file 'app/views/root/_device_count.html.slim', <<~'CODE'.strip_heredoc
  #test-channel-device-count
    span> = pluralize(Device.connected.count, 'device')
    | present
CODE

file 'app/views/root/_status.html.slim', <<~'CODE'.strip_heredoc
  #test-channel-status
    | connecting...
CODE

file 'app/views/root/index.html.slim', <<~'CODE'.strip_heredoc
  h1 = test_helper(content: 'Root')
  = render 'status'
  = render 'device_count'
CODE

file 'test/controllers/root_controller_test.rb', <<~'CODE'.strip_heredoc
  require 'test_helper'

  class RootControllerTest < ActionDispatch::IntegrationTest
    describe '#index' do
      test 'page loads' do
        get root_url
        assert_response :ok
      end
    end
  end
CODE

file 'test/system/load_root_test.rb', <<~'CODE'.strip_heredoc
  require "application_system_test_case"

  class LoadRootTest < ApplicationSystemTestCase
    test "root page loads" do
      visit root_url
      assert_selector "h1", text: "Root"
    end
  end
CODE
