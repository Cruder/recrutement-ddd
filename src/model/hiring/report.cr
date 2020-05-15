module Hiring
  class Recruiter
    def initialize(
      @id : Int32??,
      @interview : Interview,
      @recruiter : Recruiter
    )
    end

    def initialize(data : DTO::Report, interview : DTO::Interview, recruiter: DTO::Recruiter)
      @id = data.id
      @interview = :Interview.new(interview)
      @recruiter = Recruiter.new(recruiter)
    end
  end
end
