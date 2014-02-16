class BeermappingApi

  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, expires_in:1.week ) { fetch_places_in(city) }
  end

  def self.place_location(placeId)

    Rails.cache.fetch("locationid#{placeId}", expires:1.week) { fetch_place(placeId) }
  end

  private

  def self.fetch_place(placeId)
    url = "http://beermapping.com/webservice/locquery/#{key}/"
    #url = "http://stark-oasis-9187.herokuapp.com/api/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(placeId)}"

    place = response.parsed_response["bmp_locations"]["location"]

    return [] if place.is_a?(Hash) and place['id'].nil?
    return place
  end


  def self.fetch_places_in(city)
    #url = "http://beermapping.com/webservice/loccity/#{key}/"
    url = "http://stark-oasis-9187.herokuapp.com/api/"
    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end

  def self.key
    #"f6477dd2bd97a6ccf5818781d1bd9c6c"
    Settings.beermapping_apikey
  end
end
