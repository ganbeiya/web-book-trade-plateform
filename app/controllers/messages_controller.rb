
class MessagesController < ApplicationController
    before_action :authenticate_user!

    def index
        @inbox = Message
          .where(receiver_id: current_user.id, receiver_deleted: [false, nil])
          .includes(:sender, :book)
      
        @sent = Message
          .where(sender_id: current_user.id, sender_deleted: [false, nil])
          .includes(:receiver, :book)
    end
      
    # Send a message to another user with updating reply status
    def create
        @message = current_user.sent_messages.new(message_params)
    
        if @message.save
        # Update reply status
        if params[:reply_to_id].present?
            original = Message.find_by(id: params[:reply_to_id])
            if original
            # Update replied_by_receiver when current user is the receiver of the message
            if original.receiver_id == current_user.id
                original.update(replied_by_receiver: true)
            # Update replied_by_sender when current user is the sender of the message  
            elsif original.sender_id == current_user.id
                original.update(replied_by_sender: true)
            end
            end
        end
        redirect_to book_path(@message.book), notice: "Message sent!"
        else
        redirect_to book_path(@message.book), alert: "Failed to send message!"
        end
    end
  
    # Prepares a new message instance with preset receiver_id, book_id, and replied user id.
    # so the form can display them without user input
    def new
        @message = Message.new(
          receiver_id: params[:receiver_id],
          book_id: params[:book_id]
        )
        @reply_to_id = params[:reply_to_id]
    end
    
    # Soft-delete a message from the current user's inbox or sent messages
    def destroy
        message = Message.find(params[:id])
        if current_user.id == message.sender_id
            message.update(sender_deleted: true)
        elsif current_user.id == message.receiver_id
            message.update(receiver_deleted: true)
        end
        redirect_to messages_path, notice: "Message deleted"
    end
      

    private
    
     # Strong parameters: allow only permitted fields
    def message_params
      params.require(:message).permit(:content, :receiver_id, :book_id)
    end
end
