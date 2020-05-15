module Hiring
  class Room
    getter name : String
    getter booked_on : Availability

    def initialize(@id : Int32?, @name : String)
      @booked_on = Availability.new(Time.utc, Time.utc)
    end

    def initialize(data : DTO::Room)
      @id = data.id
      @name = data.name
      @booked_on = Availability.new(Time.utc, Time.utc)
    end

    def initialize(data : DTO::Room, booked_on : DTO::Availability)
      @id = data.id
      @name = data.name
      @booked_on = Availability.new(booked_on.start_at, booked_on.end_at)
    end

    def self.booking(room : DTO::Room, booked_on : DTO::Availability)
      new(room, booked_on)
    end

    def to_dto
      DTO::Room.new(@id, @name, [DTO::Availability.new(@booked_on.start_at, @booked_on.end_at)])
    end
  end
end
# computer
# size
# horaire
