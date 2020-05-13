require "./repository"

abstract class InterviewRepository
  alias Model = Hiring::Interview

  include Repository(Model)

  abstract def add(interview : Model)
end