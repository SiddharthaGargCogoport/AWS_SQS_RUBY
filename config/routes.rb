Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'publish_message' to: 'cipher_dispatcher#publish_message'
  get 'queue_poller_1', to: 'infinity_interceptor#receiver1'
  get 'queue_poller_2', to: 'infinity_interceptor#receiver2'
end
