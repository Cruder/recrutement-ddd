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
      available_rooms = @room_repository.all.select do |item|
        conflicting_dates = item.booked_dates.select &.matches?(request.creneau)
        conflicting_dates.empty?
      end
      # When
      room_to_book = available_rooms.first
      room = Room.booking(room_to_book, request.creneau)
      data = room.to_dto

      # Then
      room_to_book.booked_dates.concat(data.booked_dates)
      @room_repository.update(data)
      data
    end
  end
end
