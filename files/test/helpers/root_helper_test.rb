# frozen_string_literal: true

class RootHelperTest < ActionView::TestCase
  test 'returns the same content' do
    content = 'testing123'
    assert_dom_equal 'testing123', test_helper(content: content)
  end
end
