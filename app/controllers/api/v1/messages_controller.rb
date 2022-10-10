class Api::V1::MessagesController < ApplicationController

  # GET: /api/v1/messages
  def index
    messages = Message.joins(:chat).select("messages.*, chats.number as chat_number")
    render json: MessageResponse.new(messages).as_db_json
  end

  # POST: /api/v1/messages
  def create
    sqs = Aws::SQS::Client.new(endpoint: 'http://localhost:4566', region: 'us-east-1')
    # In case getting an error with creating a SQS queue,
    # Uncomment next line and use it instead of #ENV['MESSAGE_QUEUE_URL']
    # queue_url = sqs.create_queue(queue_name: "instabug_messages")[:queue_url]
    sqs.send_message(
      queue_url: ENV['MESSAGE_QUEUE_URL'],
      message_body: JSON.generate({chat_id: params[:chat_id],
                                   body: params[:body]})
    )
    render status: :ok
  end

  # GET: /api/v1/messages/search?query=''
  def search
    query = params["query"] || ""
    res = Message.search(query)
    render json: MessageResponse.new(res.response["hits"]["hits"]).as_json
  end
end
