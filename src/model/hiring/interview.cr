module Hiring
  class Interview
    def self.plan(candidate : DTO::Candidate, recruiters : Array(DTO::Recruiter))
      new(Candidate.new(candidate), recruiters.map { |recruiter| Recruiter.new(recruiter) })
    end

    def initialize(
      @candidate : Candidate,
      @recruiters : Array(Recruiter),
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

    def to_dto
      DTO::Interview.new(0)
    end
  end
end
