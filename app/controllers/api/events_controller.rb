class API::EventsController < ApplicationController
#production level would use a CSRF security token
  skip_before_action :verify_authenticity_token

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