module Hiring
  class Interview
    enum Status
      Pending
      Created
      Canceled
      Finished
    end

    def self.plan(candidate : DTO::Candidate, recruiters : Array(DTO::Recruiter))
      recruiters = recruiters.map { |recruiter| Recruiter.new(recruiter) }
      candidate = Candidate.new(candidate)

      available_recruiters = recruiters.select &.match?(candidate)

      time_slot = candidate.availability
      new(nil, candidate, available_recruiters.first, Status::Pending, time_slot)
    end

    def initialize(
      @id : Int32?,
      @candidate : Candidate,
      @recruiter : Recruiter,
      @status : Status,
      @booked_date : TimeSlot
    )
    end

    def initialize(data : DTO::Interview, candidate : DTO::Candidate, recruiter : DTO::Recruiter)
      @id = data.id
      @candidate = Candidate.new(candidate)
      @recruiter = Recruiter.new(recruiter)
      @status = str_status(data.status)
      @booked_date = TimeSlot.new(data.booked_date)
    end

    def cancel
      @status = Status::Canceled unless @status == Status::Finished
    end

    def to_dto
      DTO::Interview.new(@id, status_str, @booked_date.to_dto)
    end

    private def status_str
      case @status
      when Status::Pending  then "pending"
      when Status::Created  then "created"
      when Status::Canceled then "canceled"
      when Status::Finished then "finished"
      else                       "unknown"
      end
    end

    private def str_status(str : String)
      case str
      when "pending"  then Status::Pending
      when "created"  then Status::Created
      when "canceled" then Status::Canceled
      when "finished" then Status::Finished
      else                 raise "Invalid Status"
      end
    end
  end
end
