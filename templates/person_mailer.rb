file 'app/mailers/person_mailer.rb', <<~CODE.strip_heredoc
  class PersonMailer < ApplicationMailer
    def test(person:)
      @person = person

      mail(
        to: person.email,
        subject: "This is a test"
      )
    end
  end
CODE

file 'app/views/person_mailer/test.html.slim', <<~CODE.strip_heredoc
  h1 Test email

  p = @person.full_name
CODE

file 'test/mailers/person_mailer_test.rb', <<~CODE.strip_heredoc
  require 'test_helper'

  class PersonMailerTest < ActionMailer::TestCase
    test "test email sends" do
      person = people(:one)

      email = PersonMailer.test(person: person).deliver
      refute ActionMailer::Base.deliveries.empty?

      assert_equal [person.email], email.to
      assert_equal "This is a test", email.subject
    end
  end
CODE

file 'test/mailers/previews/person_mailer_preview.rb', <<~CODE.strip_heredoc
  # Preview all emails at http://localhost:3000/rails/mailers/person_mailer
  class PersonMailerPreview < ActionMailer::Preview

  end
CODE
