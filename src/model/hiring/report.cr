module Hiring
  class Report
    def initialize(
      @id : Int32??,
      @body : String,
      @interview : Interview,
      @recruiter : Recruiter
    )
    end

    def initialize(data : DTO::Report, interview : DTO::Interview, recruiter: DTO::Recruiter)
      @id = data.id
      @body = data.body
      @interview = Interview.new(interview)
      @recruiter = Recruiter.new(recruiter)
    end

    def self.write(body : String, interview : DTO::Interview, recruiter: DTO::Recruiter)
      interview = Interview.new(interview)
      recruiter = Recruiter.new(recruiter)

      new(nil, body, interview, recruiter)
    end

    def to_dto
      DTO::Report.new(@id, @body, @interview.id, @recruiter.id)
    end
  end
end
