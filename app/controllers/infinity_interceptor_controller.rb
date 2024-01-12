class InfinityInterceptorController < ApplicationController 
    skip_before_action :verify_authenticity_token 
    def receiver2
        if rand < 0.4
            raise 'Failed to Process request'
        else
           result =  receiver1
        end
    render json: { response: result}
    end


    def receiver1
        queue_url = Rails.application.config.sqs_queue_url
        poll_interval = 5.seconds
    
        loop do
          poll_queue(queue_url)
          sleep poll_interval
        end
    end
    
      # private
    
      def poll_queue(queue_url)
        sqs_client = Aws::SQS::Client.new
        response = sqs_client.receive_message({
            queue_url: queue_url, 
            message_attribute_names: ["All"], # Receive all custom attributes.
            max_number_of_messages: 4, # Receive at most 4 message.
            wait_time_seconds: 5
          })
        response.messages.each do |msg|
            Rails.logger.info msg.body
            begin 
              sqs_client.delete_message({queue_url: queue_url,receipt_handle: msg.receipt_handle})
             rescue =>error
              # logic to add processed msg to some to be deleted queue in database because it can't be deleted
              Rails.logger.info 'Message deletion failed'
             end
          unique_number = msg.message_attributes['unique_number']
          puts unique_number
           # make the http call with header here
        end
      end
end