require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"

    require 'json'


    parsed_data = JSON.parse(open(url).read)

    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]



   url = "https://api.forecast.io/forecast/3369840cf488b3c66ced3b93fd331d77/#{@latitude},#{@longitude}"

    raw_data_f = open(url).read

    require 'json'

    parsed_data_f = JSON.parse(raw_data_f)


    @current_temperature = parsed_data_f["currently"]["temperature"]

    @current_summary = parsed_data_f["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_f["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_f["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_f["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
