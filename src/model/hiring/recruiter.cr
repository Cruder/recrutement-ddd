module Hiring
  class Recruiter
    getter skills : Array(Skill)
    getter availabilities : Array(Availability)

    def initialize(data : DTO::Recruiter)
      @skills = Array(Skill).new
      @availabilities = Array(Availability).new
    end
  end
end
