module Phoneparse

  # ValidationError class
  class ValidationError < StandardError
    def initialize
      super %Q{The phone number is not valid.}
    end
  end

  class Phone
    # class initialization method
    #
    # ==== Attributes
    #
    # * +number+   - Phone number for parsing
    # * +options+  - Country specification for parsing (2 or 3 letters)
    #   or ip address
    #
    # examples: 
    #  - Phoneparse::Phone.new('0646722954', country: 'FR')
    #  - Phoneparse::Phone.new('0646722954', country: 'FRA')
    #  - Phoneparse::Phone.new('0646722954', ip: '87.231.10.234')
    #
    def initialize(number, options = {})
      country = options[:country] || nil
      ip = options[:ip] || nil

      @number = number

      # Get the country
      @country = Phoneparse.default_country
      if not country.nil?
        _country = ::Country.find_country_by_alpha2(country.to_s) || ::Country.find_country_by_alpha3(country.to_s)
        if not _country.nil?
          @country = _country.alpha2
        end
      end
      if country.nil? and not ip.nil?
        @ip = ip
        _s = ::Geocoder.search(@ip).first
        if not _s.nil?
          @country = _s.country_code
        end
      end

      @phone = {}
      if @country.nil?
        @phone = Phonelib::Phone.new(@number)
      else
        @phone = Phonelib::Phone.new(@number, @country)
      end

      @data = {} 
      if not @phone.nil?
        @data = @phone.instance_variable_get :@data
      end
    end

    # Returns the original number passed for parsing
    def original_number
      @number
    end

    # method to get sanitized phone number (only numbers)
    def sanitized_number
      @number && @number.gsub(/[^0-9]+/, '') || ''
    end

    # Returns all phone types that matched valid patterns
    def types
      @phone.types
    end

    # Returns all possible types that matched possible patterns
    def possible_types
      @phone.possible_types
    end

    # Returns first phone type that matched
    def type
      @phone.type
    end

    # Returns all countries that matched valid patterns
    def countries
      @phone.countries
    end

    # Return countries with valid patterns
    def valid_countries
      @phone.valid_countries
    end

    # Returns first country that matched valid patterns
    def country
      @phone.country
    end

    # Returns first country code
    def country_code
    end

    # Returns formatted national number
    def national_number
      @phone.national
    end

    # Returns E164 formatted phone number
    def international_number
      @phone.international
    end

    # Returns whether a current parsed phone number is valid
    def valid?
      Phonelib.valid? @phone.international
    end

    # Normalizes the phone number.
    def normalize
      raise ValidationError.new unless valid?
      Phony.normalize(@phone.international)
    end

    # Formats a E164 number according to local customs.
    def format(options={})
      raise ValidationError.new unless valid?
      Phony.format(normalize, options)
    end

    # Splits the phone number into pieces according to the country codes.
    def split
      raise ValidationError.new unless valid?
      Phony.split(normalize)
    end

    def inspect
      _r = "#<#{self.class}:0x00%x @number=\"#{@number.to_s}\" @country=\"#{@country.to_s}\" @ip=\"#{@ip}\" @data=#{@data}>" % [self.object_id.abs*2]
      %Q{#{_r}}
    end
  end
end