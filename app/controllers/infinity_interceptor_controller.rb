class InfinityInterceptorController < AppplicationController 
    skip_before_action :verify_authenticity_token 
    def receiver2
        if rand < 0.4
            raise 'Failed to Process request'
        else
           result =  receiver1
        end
    render json: { response: 'ok'}
    end


    def receiver1
        queue_url = Rails.application.config.sqs_queue_url
        poll_interval = 5.seconds
    
        loop do
          poll_queue(queue_url)
          sleep poll_interval
        end
      end
    
      private
    
      def poll_queue(queue_url)
        sqs_client = Aws::SQS::Client.new
        queue_poller = Aws::SQS::QueuePoller.new(queue_url, client: sqs_client)
        
        queue_poller.poll(wait_time_second: 5) do |msg|
         puts msg.body
         unique_number = msg.attributes['unique_number']

        # call to cipher_deceptor service here 
        end
      end
end