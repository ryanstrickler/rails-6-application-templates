FORMAT = '%Y%m%d%H%M%S'

file 'app/models/person.rb', <<~CODE.strip_heredoc
  class Person < ApplicationRecord
    validates :first_name, :last_name, presence: true
    
    def full_name
      "#{first_name} #{last_name}"
    end

    def email
      'testing@test123.com'
    end
  end
CODE

file "db/migrate/#{Time.now.utc.strftime(FORMAT)}_create_people.rb", <<~CODE.strip_heredoc
  class CreatePeople < ActiveRecord::Migration[6.0]
    def change
      create_table :people do |t|
        t.string :first_name, null: false
        t.string :last_name, null: false

        t.timestamps
      end
    end
  end
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
