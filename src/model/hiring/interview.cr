module Hiring
  class Interview
    enum Status
      Pending
      Created
      Finished
    end

    def self.plan(candidate : DTO::Candidate, recruiters : Array(DTO::Recruiter))
      recruiters = recruiters.map { |recruiter| Recruiter.new(recruiter) }
      candidate = Candidate.new(candidate)

      available_recruiters = candidate.skills.map do |skill|
        recruiters.select { |recruiter| recruiter.skills.includes?(skill) }
      end.reduce(Array(Recruiter).new) do |acc, recruiters|
        acc | recruiters
      end.select do |recruiters|
        recruiters.availabilities.any? do |availability|
          availability.match?(candidate.availability)
        end
      end

      new(nil, candidate, available_recruiters.first, Status::Pending)
    end

    def initialize(
      @id : Int32??,
      @candidate : Candidate,
      @recruiter : Recruiter,
      @status : Status
    )
    end

    def initialize(data : DTO::Interview, candidate : DTO::Candidate, recruiter : DTO::Recruiter)
      @id = data.id
      @candidate = Candidate.new(candidate)
      @recruiter = Recruiter.new(recruiter)
      @status = str_status(data.status)
    end

    def plan
      available_recruiters = @candidate.skills.map do |skill|
        recruiters.select { |recruiter| recruiter.skills.includes?(skill) }
      end.reduce(Array(Recruiter).new) do |acc, recruiters|
        acc | recruiters
      end.select do |recruiters|
        recruiters.availabilities.any? do |availability|
          availability.match?(@candidate.availability)
        end
      end
    end

    def to_dto
      DTO::Interview.new(@id, status_str)
    end

    private def status_str
      case @status
      when Status::Pending  then "pending"
      when Status::Created  then "created"
      when Status::Finished then "finished"
      else "unknown"
      end
    end

    private def str_status(str : String)
      case str
      when "pending" then Status::Pending
      when "created" then Status::Created
      when "finished" then Status::Finished
      else raise "Invalid Status"
      end
    end
  end
end
