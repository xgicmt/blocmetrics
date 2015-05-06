class API::EventsController < ApplicationController
#production level would use a CSRF security token
  skip_before_action :verify_authenticity_token

  ############################## LETS TRY SOME CORS ###############################
before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers
 
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end
 
  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'
 
      render :text => '', :content_type => 'text/plain'
    end
  end
####################################################################################### 
  def create
    registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])
    if registered_application == nil
      render json: "Unregistered application", status: :unprocessable_entity 
    end
    #@event = registered_application.events.create(event_params)
    @event = registered_application.events.build(event_params)
    if @event.save
      render json: @event, status: :created
    else
      render @event.errors, status: :unprocessable_entity
    end

  end

private

  def event_params
    params.require(:event).permit(:eventname)
   # params.require(:eventname)
  end

end

# curl -v -H "Accept: application/json" -H "Origin: http://haag.info/reanna_greenholt" -H "Content-Type: application/json" -X POST -d '{"eventname":"foobar"}' http://localhost:3000/api/events


