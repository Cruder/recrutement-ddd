module Hiring
  # Given
  #
  # And
  #
  # When
  #
  # Then
  #
  class WriteReport
    def initialize(
      @interview_repository : InterviewRepository,
      @candidate_repository : CandidateRepository,
      @recruiter_repository : RecruiterRepository,
      @report_repository : ReportRepository,
    )
    end

    def call(request) : DTO::Report
      # Given


      # When


      # Then
    end
  end
end
