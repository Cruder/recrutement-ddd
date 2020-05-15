module Hiring
  class Availability
    protected getter start_at : Time
    protected getter end_at : Time

    def self.make_busy_time(actual, busy) : {Availability, Availability}
      beginning = Availability.new(actual.start_at, busy.start_at)
      ending = Availability.new(busy.end_at, actual.end_at)

      {beginning, ending}
    end

    def initialize(availability : DTO::Availability)
      initialize(availability.start_at, availability.end_at)
    end

    def initialize(@start_at : Time, @end_at : Time)
      raise "Starts on weekend" if @start_at.saturday? || @start_at.sunday?
      raise "Ends on weekend" if @end_at.saturday? || @end_at.sunday?
      raise "end_at must be greater than start_at" if @end_at < @start_at
    end

    def match?(availability : Availability)
      start_at <= availability.start_at &&
        end_at >= availability.end_at
    end

    def ==(availability : Availability)
      start_at == availability.start_at && end_at == availability.end_at
    end
  end
end
