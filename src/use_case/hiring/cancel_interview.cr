module Hiring
  # Given
  #   A pending | created interview
  # When
  #   The HR cancels the interview
  # Then
  #   The interview is canceled
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
