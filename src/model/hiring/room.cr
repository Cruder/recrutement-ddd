module Hiring
  class Room
    getter name : String

    def initialize(@name)
    end
  end

  class RoomBooking
    protected getter room : Room
    protected getter start_at : Time
    protected getter end_at : Time

    def initialize(@room : Room, @start_at : Time, @end_at : Time)
    end
  end
end
