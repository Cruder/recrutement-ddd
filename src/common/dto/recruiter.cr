module DTO
  record Recruiter,
    id : Int32?,
    name : String,
    skills : Array(Skill),
    availabilities : Array(TimeSlot),
    lvl_skills : Int32
end
