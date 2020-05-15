module Hiring
  # Given
  #   A interview that is going to be scheduled tomorrow
  # And
  #   A bunch of rooms with availabilities
  # When
  #   The HR book a room available for tomorow
  # Then
  #   The room is booked for a date tomorrow
  class BookRoom
    def initialize(
      @room_repository : RoomRepository
    )
    end

    def call(request) : DTO::Interview
      # Given
      rooms = @room_repository

      # When
      room = Room.booking(rooms, request.creneau)
      data = room.to_dto

      # Then
      room_to_book.booked_dates.concat(data.booked_dates)
      @room_repository.update(data)
      data
    end
  end
end
