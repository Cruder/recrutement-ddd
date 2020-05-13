module Hiring
  class Interview
    def initialize(
      @candidate : Candidate,
      @recruiters : Array(Recruiter),
      @rooms : Array(Room)
    )
    end

    def plan
      available_recruiters = @candidate.skills.map do |skill|
        @recruiters.select { |recruiter| recruiter.skills.includes?(skill) }
      end.reduce(Array(Recruiter).new) do |acc, recruiters|
        acc | recruiters
      end.select do |recruiters|
        recruiters.availabilities.any? do |availability|
          availability.match?(@candidate.availability)
        end
      end
    end
  end
end
