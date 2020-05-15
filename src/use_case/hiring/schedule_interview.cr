module Hiring
  # Given
  #   A Java candidate available tomorow
  # And
  #   Some recruiters with availabilities and skills base
  # And
  #   We are 01-06-2020
  # And
  #   A bunch of rooms with availabilities
  # When
  #   The HR schedules an interview with the candidate for tomorow
  # Then
  #   An interview is scheduled for the candidate with a recruiter tomorrow
  class ScheduleInterview
    def initialize(
      @interview_repository : InterviewRepository,
      @candidate_repository : CandidateRepository,
      @recruiter_repository : RecruiterRepository,
      @room_repository : RoomRepository
    )
    end

    def call(request) : DTO::Interview
      # Given
      candidate = @candidate_repository.find_by_id(request.candidate_id)
      recruiters = @recruiter_repository.for_month(Time.utc.month)
      rooms = @room_repository.all

      # When
      interview = Interview.plan(candidate, recruiters)
      interview_dto = interview.to_dto
      room = Rooms::Room.booking(rooms, candidate.availability)
      room_dto = room && room.to_dto
      recruiter = Recruiter.plan(interview.recruiter.to_dto, candidate.availability)
      recruiter_dto = recruiter.to_dto

      # Then
      if room_dto
        @room_repository.update(room_dto)
        @interview_repository.add(interview_dto)
        @recruiter_repository.update(recruiter_dto)
      end

      interview_dto
    end
  end
end
