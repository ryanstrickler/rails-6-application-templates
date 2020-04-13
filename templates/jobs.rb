file 'test/jobs/test_job_test.rb', <<~CODE.strip_heredoc
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
CODE

file 'app/jobs/test_job.rb', <<~CODE.strip_heredoc
  class TestJob < ApplicationJob
    queue_as :default

    def perform(*args)
      logger.debug 'This is only a test.'
    end
  end
CODE
