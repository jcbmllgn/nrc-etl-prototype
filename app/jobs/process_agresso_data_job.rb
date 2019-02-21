class ProcessAgressoDataJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    AgressoDataProcessor.run()
  end
end
