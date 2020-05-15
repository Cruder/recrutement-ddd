module Hiring
  class Candidate
    getter skills : Array(Skill)
    getter availability : Availability

    def initialize(data : DTO::Candidate)
      @skills = data.skills.map { |skill| Hiring.dto_to_skill(skill) }
      @availability = Availability.new(data.availability)
    end

    def id
      0
    end
  end
end
