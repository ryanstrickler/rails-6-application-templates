FORMAT = '%Y%m%d%H%M%S'

file 'app/models/person.rb', <<~CODE.strip_heredoc
  class Person < ApplicationRecord
    validates :first_name, :last_name, presence: true
  end
CODE

file "db/migrate/#{Time.now.utc.strftime(FORMAT)}_create_people.rb", <<~CODE.strip_heredoc
CODE

file 'test/fixtures/people.yml', <<~CODE.strip_heredoc
  one:
    first_name: Luke
    last_name: Skywalker
CODE

file 'test/models/person_test.rb', <<~CODE.strip_heredoc
  require 'test_helper'

  class PersonTest < ActiveSupport::TestCase
    setup do
      @person = people(:one)
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
  end
CODE
