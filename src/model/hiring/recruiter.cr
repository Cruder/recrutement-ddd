module Hiring
  class Recruiter
    getter skills : Array(Skill)
    getter availabilities : Array(Availability)

    def initialize(@skills, @availabilities)
    end
  end
end
