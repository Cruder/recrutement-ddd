module DTO
  record Room,
    id : Int32?,
    name : String,
    booked_dates : Array(Availability)
end
