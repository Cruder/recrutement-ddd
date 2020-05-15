require "./skill"

module Hiring
  class Recruiter
    getter skills : Array(Skill)
    getter availabilities : Array(TimeSlot)
    getter lvl_skills : Int32

    @name : String

    def initialize(data : DTO::Recruiter)
      @lvl_skills = data.lvl_skills
      @name = data.name
      @skills = data.skills.map { |skill| Hiring.dto_to_skill(skill) }
      @availabilities = data.availabilities.map { |availability| TimeSlot.new(availability) }
    end

    def match?(candidate : Candidate)
      have_skills?(candidate.skills) && available?(candidate.availability) && more_senior?(candidate.lvl_skills)
    end

    private def have_skills?(skills : Array(Skill))
      (skills - @skills).empty?
    end

    private def available?(availability : TimeSlot)
      availabilities.any? do |segment|
        segment.match?(availability)
      end
    end

    private def more_senior?(lvl_skills : Int32)
      @lvl_skills >= lvl_skills
    end
  end
end
