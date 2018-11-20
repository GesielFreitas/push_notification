class NotificationsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def push

	    jsonbody = JSON.parse request.body.read()
	    endpoint = jsonbody["subscription"]["endpoint"]
	    p256h = jsonbody["subscription"]["keys"]["p256dh"]
	    auth = jsonbody["subscription"]["keys"]["auth"]
	    
	    @notification = Notification.new(endpoint: endpoint, p256h: p256h, auth: auth)
	    @notification.save!
      redirect_to push_send_path
  end

  def pushSend
      message
  end

  def message
    @notification = Notification.last
    	#for notif in @notifications
     	#	begin
       			Webpush.payload_send(
           			message: get_message,
           			endpoint: @notification.endpoint,
           			p256dh: @notification.p256h,
           			auth: @notification.auth,
           			ttl: 24 * 60 * 60,
           			vapid: {
               			subject: 'mailto:gesiel.was.f@gmail.com',
               			public_key: ENV['VAPID_PUBLIC_KEY'],
               			private_key: ENV['VAPID_PRIVATE_KEY']
           			}
       			)
     	#	rescue
     	#	end
    	#end
  end

  def get_message
    "mensagem enviada com sucesso"
  end

end


