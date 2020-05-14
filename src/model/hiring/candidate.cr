module Hiring
  class Candidate
    getter skills : Array(Skill)
    getter availability : Availability

    def initialize(data : DTO::Candidate)
      @skills = Array(Skill).new
      @availability = Availability.new(Time.utc, Time.utc)
    end

    def id
      0
    end
  end
end
