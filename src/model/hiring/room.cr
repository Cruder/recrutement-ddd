module Hiring
  class Room
    getter name : String
    getter booked_on : TimeSlot

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

    def self.booking(room : DTO::Room, booked_on : DTO::TimeSlot)
      new(room, booked_on)
    end

    def to_dto
      DTO::Room.new(@id, @name, [DTO::TimeSlot.new(@booked_on.start_at, @booked_on.end_at)])
    end
  end
end
# computer
# size
# horaire
