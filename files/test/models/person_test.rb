# frozen_string_literal: true

require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  setup do
    @person = people(:one)
  end

  describe 'fixture' do
    test 'valid as generated' do
      assert @person.valid?
    end
  end

  describe 'validations' do
    test 'first name required' do
      @person.first_name = nil
      refute @person.valid?
    end

    test 'last name required' do
      @person.last_name = nil
      refute @person.valid?
    end
  end

  describe 'methods' do
    describe 'full_name' do
      test 'combines first/last name' do
        assert_equal 'Luke Skywalker', @person.full_name
      end
    end

    describe 'email' do
      test 'fake value for now' do
        assert_equal 'testing@test123.com', @person.email
      end
    end
  end
end
