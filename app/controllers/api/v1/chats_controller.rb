require 'aws-sdk-sqs'

class Api::V1::ChatsController < ApplicationController

  # GET /api/v1/chats
  def index
    chats = Chat.joins(:application).select("chats.*, applications.token as application_token")
    render json: ChatResponse.new(chats).as_json
  end

  # POST /api/v1/chats
  def create
    sqs = Aws::SQS::Client.new(endpoint: 'http://localhost:4566', region: 'us-east-1')
    # In case getting an error with creating a SQS queue,
    # Uncomment next line and use it instead of #ENV['CHAT_QUEUE_URL']
    # queue_url = sqs.create_queue(queue_name: "instabug_chats")[:queue_url]
    sqs.send_message(
      queue_url: ENV['CHAT_QUEUE_URL'],
      message_body: params[:token]
    )
    render status: :ok
  end

  # GET: /api/v1/chats/applications/:application_token
  def application_chats
    chats = Chat.joins(:application)
                .select("chats.*, applications.token as application_token")
                .where(applications: {token: params[:application_token]})
    render json: ChatResponse.new(chats).as_json
  end

  # GET: /api/v1/chats/:id
  def show
    chat = Chat.find(params[:id]);
    render json: chat, status: :ok
  end

  # PUT: /api/v1/chats/:id
  def edit
    chat = Chat.find(params[:id])
    if chat
      chat.update(application_params)
      render json: chat, status: :ok
    else
      render json: {error: 'Unable to update Chat'}, status: 400
    end
  end
end
