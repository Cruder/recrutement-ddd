module Hiring
  class Room
    getter name : String

    def initialize(data : DTO::Room)
      @name = data.name
    end
  end
end
