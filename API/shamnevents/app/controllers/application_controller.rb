class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  respond_to :json
  
  protect_from_forgery with: :null_session
  
  OFFSET = 0
  LIMIT = 30
  
  # Helpers used
  include EventsHelper, ApiHelper

  # Used to set offset and limits if the user wishes to use this
  def offset_params
    if params[:offset].present?
      @offset = params[:offset].to_i
    end
    
    if params[:limit].present?
      @limit = params[:limit].to_i
    end
    
    @offset ||= OFFSET
    @limit  ||= LIMIT
  end
  
  # Method to check for API Key in HTTP Header
  def api_key
    api_key = request.headers['X-ApiKey']
    
    #while false do
    #  if 1 == 1
    #    break
    #  end     
    #end
    
    if api_key.present?
      return true
    else
      no_valid_api_key
      return false
    end
  end
end
