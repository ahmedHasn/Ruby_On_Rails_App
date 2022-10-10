# require 'thread'
# Thread.abort_on_exception = true
# Thread.now do
#   queue_url = 'http://localhost:4566/000000000000/instabug_chats'
#   poller = Aws::SQS::QueuePoller.new(queue_url)
#   poller.poll do |message|
#     puts message.body
#     logger.info message.body
#     message.delete
#   end
# end

# Thread.abort_on_exception = true
# t1 = Thread.new do
#   puts  "In new thread"
#   raise "Exception from thread"
# end
# sleep(1)
# puts "not reached"

t = Thread.new do
    queue_url = 'http://localhost:4566/000000000000/instabug_chats'
    poller = Aws::SQS::QueuePoller.new(queue_url)
    poller.poll do |message|
      ChatJob.perform_later message.body
    end
  end
t.abort_on_exception = true