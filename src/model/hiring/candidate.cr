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
