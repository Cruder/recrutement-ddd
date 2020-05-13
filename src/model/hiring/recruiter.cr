module Hiring
  class Recruiter
    getter skills : Array(Skill)
    getter availabilities : Array(Availibility)

    def initialize(@skills, @availabilities)
    end
  end
end
