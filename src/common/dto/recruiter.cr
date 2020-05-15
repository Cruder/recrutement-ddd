module DTO
  record Recruiter,
    id : Int32?,
    name : String,
    skills : Array(DTO::Skill),
    availabilities : Array(DTO::TimeSlot),
    lvl_skills : Int32
end
