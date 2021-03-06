module Hiring
  module Rooms
    class TimeSlot
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
        raise "end_at must be greater than start_at" if @end_at < @start_at
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
end
