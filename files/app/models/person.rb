# frozen_string_literal: true

class Person < ApplicationRecord
  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def email
    'testing@test123.com'
  end
end
