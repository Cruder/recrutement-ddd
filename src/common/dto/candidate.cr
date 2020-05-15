module DTO
  record Candidate,
    id : Int32?,
    name : String,
    skills : Array(Skill),
    availability : Availability
end
