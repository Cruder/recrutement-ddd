require "./repository"

abstract class RoomRepository
  alias Model = DTO::Room

  include Repository(Model)

  abstract def add(interview : Model)
  abstract def find_by_id(id)
end
