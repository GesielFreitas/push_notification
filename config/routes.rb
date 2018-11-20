Rails.application.routes.draw do
  get 'pages/index'
  post '/push' => 'notifications#push'
  post '/message' => 'notifications#message'
  get '/push_send' => 'notifications#pushSend'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
