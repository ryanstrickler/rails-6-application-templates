require "application_system_test_case"

class LoadRootTest < ApplicationSystemTestCase
  test "root page loads" do
    visit root_url
    assert_selector "h1", text: "Root"
  end
end
