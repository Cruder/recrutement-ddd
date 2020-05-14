require "./repository"

abstract class RoomRepository
  alias Model = DTO::Room

  include Repository(Model)

  abstract def add(interview : Model)
end
