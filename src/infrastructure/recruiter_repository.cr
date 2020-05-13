require "./repository"

abstract class RecruiterRepository
  alias Model = Hiring::Recruiter

  include Repository(Model)

  abstract def add(interview : Model)
  abstract def for_month(month : Int32)
end