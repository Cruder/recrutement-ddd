module Hiring
  # Given
  #   A pending | created interview
  #   assigned to a room
  #   tomorrow at 2:00pm
  #   between a recruiter and a candidate
  # When
  #   The HR | Recruiter cancels the interview
  # Then
  #   The interview is canceled
  #   The room is free tomorrow at 2:00pm
  #   The candidate is free tomorrow at 2:00pm
  #   The recruiter is free tomorrow at 2:00pm
  class CancelInterview
    def initialize(@interview_repository : InterviewRepository)
    end

    def call(request) : DTO::Interview
      # Given
      interview = @interview_repository.find_by_id(request.interview_id)

      # When
      data = interview.cancel.to_dto

      # Then
      @interview_repository.update(data)

      data
    end
  end
end
