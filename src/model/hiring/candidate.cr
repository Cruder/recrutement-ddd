module Hiring
  class Candidate
    getter skills : Array(Skill)
    getter availability : Availability

    def initialize(@skills, @availability)
    end

    def id
      0
    end
  end
end
