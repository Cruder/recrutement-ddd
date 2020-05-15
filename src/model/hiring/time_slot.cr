module Hiring
  class TimeSlot
    MAX_DURATION = Time::Span.new(hours: 3)

    protected getter start_at : Time
    protected getter end_at : Time

    def self.split_with(actual, busy) : {TimeSlot, TimeSlot}
      beginning = TimeSlot.new(actual.start_at, busy.start_at)
      ending = TimeSlot.new(busy.end_at, actual.end_at)

      {beginning, ending}
    end

    def self.remerge(timeslots : Array(TimeSlot))
      times = timeslots.sort { |a, b| a.start_at <=> b.start_at }
      times.reduce(Array(TimeSlot).new) do |acc, time|
        if acc.last?.try(&.end_at) == time.start_at
          last_time = acc.pop
          acc << TimeSlot.new(last_time.start_at, time.end_at)
        else
          acc << time
        end
      end
    end

    def initialize(availability : DTO::TimeSlot)
      initialize(availability.start_at, availability.end_at)
    end

    def initialize(@start_at : Time, @end_at : Time)
      raise "Starts on weekend" if @start_at.saturday? || @start_at.sunday?
      raise "Ends on weekend" if @end_at.saturday? || @end_at.sunday?
      raise "end_at must be greater than start_at" if @end_at < @start_at
      # Todo: Enable the 3 hours rule
      # needs to modify tests to conform this rule
      # raise "Duration too long" if @start_at - @end_at > MAX_DURATION
    end

    def match?(availability : TimeSlot)
      start_at <= availability.start_at &&
        end_at >= availability.end_at
    end

    def ==(availability : TimeSlot)
      start_at == availability.start_at && end_at == availability.end_at
    end

    def to_dto
      DTO::TimeSlot.new(start_at, end_at)
    end
  end
end
