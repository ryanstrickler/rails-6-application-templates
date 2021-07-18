# frozen_string_literal: true

require 'application_system_test_case'

class LoadHomeTest < ApplicationSystemTestCase
  test 'home page loads' do
    visit root_url
    assert_selector 'h1', text: 'Home'
  end
end
