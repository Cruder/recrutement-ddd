module Hiring
  enum Skill
    Java
    Python
    CSharp
    Php
  end
end

module Hiring
  class Candidate
    getter skills : Array(Skill)

    def initialize(@skills)
    end
  end
end

module Hiring
  class Recruiter
    getter skills : Array(Skill)
    getter availabilities : Array(Availibility)

    def initialize(@skills, @availabilities)
    end
  end
end

module Hiring
  class Availibility
    protected getter start_at : Time
    protected getter end_at : Time

    def initialize(@start_at : Time, @end_at : Time)
    end

    def match?(availability : Availibility)
      start_at < availability.start_at &&
        end_at > availability.end_at
    end
  end
end
