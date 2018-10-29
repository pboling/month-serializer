require 'month/serializer/version'

# Eternal Gems
require 'month'

class Month
  module Serializer
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def load(month_as_integer)
        raise_load_error(month_as_integer) unless month_as_integer.is_a?(Integer)
        year, number = month_as_integer.divmod(12)
        # A zero month actually points to December of the previous year,
        #   because when dividing by 12, possible remainders are 0 - 11
        #   and we need months 1 - 12
        #
        # NOTE ON ZERO:
        #
        # There is no Year Zero in the anno domini system.
        # See: https://en.wikipedia.org/wiki/Year_zero
        #
        # But ISO 8601:2004 does have a year zero, and it coincides with Gregorian year 1 BC.
        # See: https://en.wikipedia.org/wiki/ISO_8601
        #
        # And what about Ruby?
        #
        # >> Date.new(0, 1, 1)
        # => #<Date: 0000-01-01 ((1721058j,0s,0n),+0s,2299161j)>
        # >> Date.new(0, 1, 1) << 1
        # => #<Date: -0001-12-01 ((1721027j,0s,0n),+0s,2299161j)>
        # >> Date.new(0, 1, 1) >> 12
        # => #<Date: 0001-01-01 ((1721424j,0s,0n),+0s,2299161j)>
        # >> Date.new(2018, 1, 1) >> 12
        # => #<Date: 2019-01-01 ((2458485j,0s,0n),+0s,2299161j)>
        #
        # We want a line of integers that represent months that are unbroken
        #   steps of distance 1, so we have to have a Month 0
        #
        # Month -24 is December, Year -3  # -24.divmod(12) => [-2, 0]   # year -= 1, number = 12
        # Month -23 is January, Year -2   # -23.divmod(12) => [-2, 1]   # no mod
        # Month -12 is December, Year -2  # -12.divmod(12) => [-1, 0]   # year -= 1, number = 12
        # Month -11 is January, Year -1   # -11.divmod(12) => [-1, 1]   # no mod
        # Month -10 is February, Year -1  # -10.divmod(12) => [-1, 2]   # no mod
        # Month -2 is October, Year -1    # -2.divmod(12) => [-1, 10]   # no mod
        # Month -1 is November, Year -1   # -1.divmod(12) => [-1, 11]   # no mod
        # Month 0 is December, Year -1    # 0.divmod(12) => [0, 0]      # year -= 1, number = 12
        # Month 1 is January, Year 0      # 1.divmod(12) => [0, 1]      # no mod
        # Month 2 is February, Year 0     # 2.divmod(12) => [0, 2]      # no mod
        # Month 11 is November, Year 0    # 11.divmod(12) => [0, 11]    # no mod
        # Month 12 is December, Year 0    # 12.divmod(12) => [1, 0]     # year -= 1, number = 12
        # Month 13 is January, Year 1     # 13.divmod(12) => [1, 1]     # no mod
        # Month 23 is November, Year 1    # 23.divmod(12) => [1, 11]    # no mod
        # Month 24 is December, Year 1    # 24.divmod(12) => [2, 0]     # year -= 1, number = 12
        # Month 25 is January, Year 2     # 25.divmod(12) => [2, 1]     # no mod
        if number.zero?
          number = 12
          year -= 1
        end
        self.new(year, number)
      end

      def dump(month)
        raise_dump_error(month) unless month.is_a?(self)
        month.to_i
      end

      private

      def active_record?
        Object.const_defined?("::ActiveRecord::SerializationTypeMismatch")
      end

      def argument_error_class
        active_record? ? ::ActiveRecord::SerializationTypeMismatch : ArgumentError
      end

      def raise_load_error(obj)
        raise argument_error_class, "Argument was supposed to be an Integer, but was a #{obj.class}. -- #{obj.inspect}"
      end

      def raise_dump_error(obj)
        raise argument_error_class, "Argument was supposed to be a #{self}, but was a #{obj.class}. -- #{obj.inspect}"
      end
    end
  end

  def to_i
    yr = year
    mon = number
    if number == 12
      mon = 0
      yr += 1
    end
    yr * 12 + mon
  end

  # Does the same thing as Month#start_date, but to_<class> is a common idiom
  #   for built-in class conversion methods.
  def to_date
    Date.new(year, number, 1)
  end
end

# Add this to the bootstrapping process of your app, somewhere after Month is loaded.
# In Rails, config/initializers/month-serializer.rb would be perfect!
# Month.send(:include, Month::Serializer)
