module EventsHelper
  def no_valid_api_key
    render json: {message: "You do not have a valid API key!"}
  end
end
