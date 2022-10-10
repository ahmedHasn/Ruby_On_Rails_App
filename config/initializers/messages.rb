t = Thread.new do
  queue_url = 'http://localhost:4566/000000000000/instabug_messages'
  poller = Aws::SQS::QueuePoller.new(queue_url)
  poller.poll do |message|
    MessageJob.perform_later message.body
  end
end
t.abort_on_exception = true
