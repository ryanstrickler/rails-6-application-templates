run 'rm config/routes.rb'
file 'config/routes.rb', <<~CODE.strip_heredoc
  Rails.application.routes.draw do
    root to: 'root#index'
  end
CODE

file 'app/controllers/root_controller.rb', <<~CODE.strip_heredoc
  class RootController < ApplicationController
    def index
    end
  end
CODE

file 'app/views/root/index.html.slim', <<~CODE.strip_heredoc
  h1 Root
CODE

file 'test/controllers/root_controller_test.rb', <<~CODE.strip_heredoc
  require 'test_helper'

  class RootControllerTest < ActionDispatch::IntegrationTest
    describe '#index' do
      test 'page loaded' do
        get root_url
        assert_response :ok
      end
    end
  end
CODE
