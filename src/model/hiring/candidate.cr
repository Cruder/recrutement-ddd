module Hiring
  class Candidate
    getter skills : Array(Skill)
    getter availability : TimeSlot
    getter lvl_skills : Int32

    def initialize(data : DTO::Candidate)
      @lvl_skills = data.lvl_skills
      @skills = data.skills.map { |skill| Hiring.dto_to_skill(skill) }
      @availability = TimeSlot.new(data.availability)
    end

    def id
      0
    end
  end
end
