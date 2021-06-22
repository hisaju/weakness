class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]

  # GET /messages or /messages.json
  def index
    if params[:category].present?
      sql = params[:category]
    else
      sql = 'SELECT * FROM messages'
    end
    @messages = ActiveRecord::Base.connection.execute(sql)
    @message = Message.new
  end

  def new
    Message.delete_all
    redirect_to messages_url
  end

  # POST /messages or /messages.json
  def create
    @message = current_user.messages.new(message_params)

    if @message.save
      redirect_to messages_url, notice: "メッセージを投稿しました"
    else
      logger.debug @message.errors
      @messages = ActiveRecord::Base.connection.execute('SELECT * FROM messages')
      render :index
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:message, :category)
    end
end
