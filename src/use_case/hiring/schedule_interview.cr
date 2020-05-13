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
    def call(candidate, recruiters, rooms)
      # Given

      # When
      available_recruiters = candidate.skills.map do |skill|
        recruiters.select { |recruiter| recruiter.skills.includes?(skill) }
      end.reduce(Array(Recruiter).new) do |acc, recruiters|
        acc | recruiters
      end.select do |recruiters|
        recruiters.availabilities.any? do |availability|
          availability.match?(candidate.availability)
        end
      end

      # Then

    end
  end
end
