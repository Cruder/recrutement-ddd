module DTO
  record Candidate,
    id : Int32?,
    name : String,
    skills : Array(Skill),
    availability : TimeSlot,
    lvl_skills : Int32
end
