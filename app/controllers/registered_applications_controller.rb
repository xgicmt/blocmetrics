class RegisteredApplicationsController < ApplicationController
  def new
    @registered_application = RegisteredApplication.new 
  end

  def create
    @registered_application = current_user.registered_applications.build(reg_app_params)
# @registered_application = RegisteredApplication.new(params.require(:registered_application).permit(:name, :URL))
      if @registered_application.save
        redirect_to @registered_application, notice: "Successfully Registered App!"
      else
        flash[:error] = "Error saving data, please try again."
        render :new
      end
  end
  
  def edit
    @registered_application = RegisteredApplication.find(params[:id])
  end
  
  def update
    @registered_application = RegisteredApplication.find(params[:id])
    if @registered_application.update_attributes(params.require(:registered_application).permit(:name, :URL))
      redirect_to @registered_application
    else
      flash[:error] = "Error saving App, please try again."
      render :edit
    end
  end

  def destroy
  end

  def show
    @registered_application = RegisteredApplication.find(params[:id])
  end

  def index
    #@registered_application = RegisteredApplication.all
    @reg_apps = current_user.registered_applications.all
  end

private

  def reg_app_params
    params.require(:registered_application).permit(:name, :URL)
  end


end


