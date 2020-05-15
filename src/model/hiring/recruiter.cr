require "./skill"

module Hiring
  class Recruiter
    getter skills : Array(Skill)
    getter availabilities : Array(TimeSlot)
    getter lvl_skills : Int32

    @name : String
    @id : Int32?

    def initialize(data : DTO::Recruiter)
      @id = data.id
      @lvl_skills = data.lvl_skills
      @name = data.name
      @skills = data.skills.map { |skill| Hiring.dto_to_skill(skill) }
      @availabilities = data.availabilities.map { |availability| TimeSlot.new(availability) }
    end

    def match?(candidate : Candidate)
      have_skills?(candidate.skills) && available?(candidate.availability) && more_senior?(candidate.lvl_skills)
    end

    def free_availability(availability : TimeSlot)
      @availabilities << availability
      @availabilities = TimeSlot.remerge(@availabilities)
    end

    def to_dto
      DTO::Recruiter.new(@id, @name, skills.map { |skill| Hiring.skill_to_dto(skill) }, availabilities.map { |time_slot| time_slot.to_dto }, lvl_skills)
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
