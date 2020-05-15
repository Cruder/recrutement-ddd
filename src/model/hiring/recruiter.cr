require "./skill"

module Hiring
  class Recruiter
    getter skills : Array(Skill)
    getter availabilities : Array(Availability)

    @name : String

    def initialize(data : DTO::Recruiter)
      @name = data.name
      @skills = data.skills.map { |skill| Hiring.dto_to_skill(skill) }
      @availabilities = data.availabilities.map { |availability| Availability.new(availability) }
    end

    def match?(candidate : Candidate)
      have_skills?(candidate.skills) && available?(candidate.availability)
    end

    private def have_skills?(skills : Array(Skill))
      (skills - @skills).empty?
    end

    private def available?(availability : Availability)
      availabilities.any? do |segment|
        segment.match?(availability)
      end
    end
  end
end
