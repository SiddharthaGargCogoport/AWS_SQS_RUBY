class CipherDispatcherController < ApplicationController
    skip_before_action :verify_authenticity_token 
    def publish_message
      unique_number = SecureRandom.random_number(1000)
      message_body = request.body.read
      sqs_client = Aws::SQS::Client.new
      queue_url = Rails.application.config.sqs_queue_url
      # Generate a random number to use as a key for metadata
     
  
      # Set up metadata as a message attribute
      metadata = { "unique_number" => { data_type: 'String', string_value: unique_number.to_s } }
  
      sqs_client.send_message(queue_url: queue_url,message_body: message_body, message_attributes: metadata)
  
      render json: { unique_number: unique_number, body: message_body }
    end
  end