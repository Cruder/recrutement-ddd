module Hiring
  module Rooms
    # Todo: Add fiels to the room
    # computer : Bool
    # size : Bool
    class Room
      getter name : String

      def self.booking(rooms : Array(DTO::Room), booked_on : DTO::TimeSlot)
        room_available = rooms.find do |room|
          room.booked_dates.none? { |date| date.start_at <= booked_on.start_at && date.end_at >= booked_on.end_at }
        end
        pp! room_available

        if room_available
          room_available.booked_dates << booked_on
          new(room_available)
        end
      end

      def initialize(@id : Int32?, @name : String, @booked_dates : Array(TimeSlot))
      end

      def initialize(data : DTO::Room)
        @id = data.id
        @name = data.name
        @booked_dates = data.booked_dates.map { |time_slot| TimeSlot.new(time_slot) }
      end

      def to_dto
        DTO::Room.new(@id, @name, @booked_dates.map { |time_slot| time_slot.to_dto })
      end
    end
  end
end
