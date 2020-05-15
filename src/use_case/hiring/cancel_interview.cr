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
  #   The recruiter is free tomorrow at 2:00pm
  class CancelInterview
    def initialize(
      @interview_repository : InterviewRepository,
      @recruiter_repository : RecruiterRepository,
      @candidate_repository : CandidateRepository,
      @room_repository : RoomRepository
    )
    end

    def call(request) : DTO::Interview
      # Given
      recruiter_dto = @recruiter_repository.find_by_id(request.recruiter_id)
      candidate_dto = @candidate_repository.find_by_id(request.candidate_id)
      room_dto = @room_repository.find_by_id(request.room_id)
      interview_dto = @interview_repository.find_by_id(request.interview_id)
      interview = Interview.new(interview_dto, candidate_dto, recruiter_dto)

      # When
      interview.cancel
      interview_dto = interview.to_dto

      # Then
      if interview_dto.status == "canceled"
        # free recruiter
        recruiter = Recruiter.new(recruiter_dto)
        recruiter.free_availability(TimeSlot.new(interview_dto.booked_date))
        recruiter_dto = recruiter.to_dto
        @recruiter_repository.update(recruiter_dto)

        # Free room
      end

      @interview_repository.update(interview_dto)

      interview_dto
    end
  end
end
