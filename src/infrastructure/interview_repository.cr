require "./repository"

abstract class InterviewRepository
  alias Model = DTO::Interview

  include Repository(Model)

  abstract def add(interview : Model)
end
