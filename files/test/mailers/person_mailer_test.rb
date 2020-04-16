# frozen_string_literal: true

require 'test_helper'

class PersonMailerTest < ActionMailer::TestCase
  test 'test email sends' do
    person = people(:one)

    email = PersonMailer.test(person: person).deliver
    refute ActionMailer::Base.deliveries.empty?

    assert_equal [person.email], email.to
    assert_equal 'This is a test', email.subject
  end
end
