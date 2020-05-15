require "./repository"

abstract class InterviewRepository
  alias Model = DTO::Interview

  include Repository(Model)

  abstract def add(interview : Model)
  abstract def find_by_id(id)
  abstract def update(interview : Model)
end
