module DTO
  record Interview,
    id : Int32?,
    status : String,
    booked_date : DTO::TimeSlot
end
