require 'open-uri'

run 'rm config/routes.rb'
file 'config/routes.rb', <<~CODE.strip_heredoc
  Rails.application.routes.draw do
    root to: 'root#index'
  end
CODE

run 'rm app/controllers/root_controller.rb'
file 'app/controllers/root_controller.rb', <<~CODE.strip_heredoc
  class RootController < ApplicationController
    def index
    end
  end
CODE

run 'rm app/helpers/root_helper.rb'
file 'app/helpers/root_helper.rb', <<~CODE.strip_heredoc
  module RootHelper
    def test_helper(content:)
      content
    end
  end
CODE

run 'rm app/views/root/index.html.slim'
file 'app/views/root/index.html.slim', <<~CODE.strip_heredoc
  h1 = test_helper(content: 'Root')
CODE

run 'rm test/controllers/root_controller_test.rb'
file 'test/controllers/root_controller_test.rb', <<~CODE.strip_heredoc
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

run 'rm test/system/load_root_test.rb'
file 'test/system/load_root_test.rb', File.read('https://raw.githubusercontent.com/ryanstrickler/rails-6-application-templates/master/files/test/system/load_root_test.rb')
