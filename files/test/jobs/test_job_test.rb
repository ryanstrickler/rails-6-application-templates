# frozen_string_literal: true

require 'test_helper'

class TestJobTest < ActiveJob::TestCase
  test 'enqueued' do
    assert_enqueued_with(job: TestJob) do
      TestJob.perform_later
    end
  end

  test 'performd' do
    ActiveSupport::Logger.any_instance.expects(:debug).once
    TestJob.perform_now
  end
end
