module Hiring
  module Rooms
    # Todo: Add fiels to the room
    # computer : Bool
    # size : Bool
    class Room
      getter name : String
      getter booked_on : TimeSlot

      def self.booking(rooms : Array(DTO::Room), booked_on : DTO::TimeSlot)
        room_available = rooms.find do |room|
          room.booked_dates.none? { |date| date.start_at < booked_on.start_at && date.end_at > booked_on.end_at }
        end

        new(room_available, booked_on)
      end

      def initialize(@id : Int32?, @name : String)
        @booked_on = TimeSlot.new(Time.utc, Time.utc)
      end

      def initialize(data : DTO::Room)
        @id = data.id
        @name = data.name
        @booked_on = TimeSlot.new(Time.utc, Time.utc)
      end

      def initialize(data : DTO::Room, booked_on : DTO::TimeSlot)
        @id = data.id
        @name = data.name
        @booked_on = TimeSlot.new(booked_on.start_at, booked_on.end_at)
      end

      def to_dto
        DTO::Room.new(@id, @name, @booked_on.to_dto)
      end
    end
  end
end
