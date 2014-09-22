module Phoneparse
  class Phone
    # defining reader methods for class variables
    attr_reader :original_number # original phone number passed for parsing

    def initialize(phone_number, country = nil, ip = nil)
      @original_number = phone_number

      # Get the country
      _c = Phoneparse.default_country
      if not country.nil?
        _country = ::Country.find_country_by_alpha2(country.to_s) || ::Country.find_country_by_alpha3(country.to_s)
        if not _country.nil?
          _c = _country.alpha2
        end
      end
      if country.nil? and not ip.nil?
        _s = ::Geocoder.search(_ip).first
        if not _s.nil?
          _c = _s.country_code
        end
      end
      
      # Parse the number
      _phone = Phonelib::Phone.new(phone_number, _c)
      @data = _phone.data
      @national_number = _phone.national_number
    end

  end
end