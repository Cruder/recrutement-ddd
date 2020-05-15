module Hiring
  # Given
  #   An interview between a recruiter and a candidate
  # When
  #   the interview ends
  # Then
  #   The recruiter writes a report
  #
  class WriteReport
    def initialize(
      @interview_repository : InterviewRepository,
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
