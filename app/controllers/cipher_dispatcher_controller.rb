class CipherDispatcherController < ApplicationController
    skip_before_action :verify_authenticity_token 
    def publish_message
      unique_number = SecureRandom.random_number(1000)
      sqs_client = Aws::SQS::Client.new
      queue_url = Rails.application.config.sqs_queue_url
      begin
        message_body = request.body.read
      # Set up metadata as a message attribute
        metadata = { "unique_number" => { data_type: 'String', string_value: unique_number.to_s } }
        response = sqs_client.send_message({queue_url: queue_url,message_body: message_body, message_attributes: metadata})
        rescue => error
            response = {
                status: error.http_code,
                message: JSON.parse(error.response).to_h['message'],
                exception: error.exception
              }.to_json rescue { message: 'Request Failed' }.to_json
        ensure
        render json: { response: response,message_body: message_body,message_attributes: metadata }
        end
    end
  end