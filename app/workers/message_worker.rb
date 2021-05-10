class MessageWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
    puts "Message has been sent"
  end
end
