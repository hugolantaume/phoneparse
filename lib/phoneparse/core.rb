module Phoneparse
  module Core

    # default country
    @@default_country = nil

    # getter method for default_country
    def default_country
      @@default_country
    end

    # setter method for default_country
    def default_country=(country)
      _country = ::Country.find_country_by_alpha2(country.to_s) || ::Country.find_country_by_alpha3(country.to_s)
      if not _country.nil?
        @@default_country = _country.alpha2
      end
    end

    # method for parsing phone number.
    def parse(number, options = {})
      Phoneparse::Phone.new(number, options)
    end
    
  end
end