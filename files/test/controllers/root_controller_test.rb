# frozen_string_literal: true

require 'test_helper'

class RootControllerTest < ActionDispatch::IntegrationTest
  describe '#index' do
    test 'page loads' do
      get root_url
      assert_response :ok
    end
  end
end
