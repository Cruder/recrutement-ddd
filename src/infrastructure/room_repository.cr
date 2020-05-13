require "./repository"

abstract class RoomRepository
  alias Model = Hiring::Room

  include Repository(Model)

  abstract def add(interview : Model)
end
