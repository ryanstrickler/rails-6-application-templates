# frozen_string_literal: true

class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    unless table_exists?(:people)
      create_table :devices do |t|
        t.string :status, null: false, default: 'disconnected'

        t.timestamps
      end
    end
  end
end
