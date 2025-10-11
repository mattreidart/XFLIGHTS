class Flight < ApplicationRecord
  belongs_to :airline

  # ---------------------------
  # ORIGIN GEOCODING
  # ---------------------------
  geocoded_by :origin, latitude: :origin_lat, longitude: :origin_lng
  after_validation :geocode_origin, if: :will_save_change_to_origin?

  # ---------------------------
  # DESTINATION GEOCODING (manual)
  # ---------------------------
  after_validation :geocode_destination, if: :will_save_change_to_destination?

  private

  # Use built-in geocode for origin
  def geocode_origin
    geocode
  end

  # Manual geocoding for destination
  def geocode_destination
    result = Geocoder.search(destination).first
    if result
      self.destination_lat = result.latitude
      self.destination_lng = result.longitude
    end
  end
end
