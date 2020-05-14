require "./repository"

abstract class CandidateRepository
  alias Model = DTO::Candidate

  include Repository(Model)

  abstract def add(interview : Model)
  abstract def find_by_id(id)
end
