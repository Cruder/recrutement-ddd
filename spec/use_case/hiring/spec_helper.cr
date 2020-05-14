require "../spec_helper"

module InMemory
  module Repository(T)
    @data = Array(T).new

    def add(model : T)
      @data << model
    end

    def all : Array(T)
      @data
    end
  end
end

record FakeRequest, candidate_id : Int32?

class CandidateMemoryRepository < CandidateRepository
  include InMemory::Repository(DTO::Candidate)

  def find_by_id(id)
    all.select { |item| item.id == id }.first
  end

  def find_by_name(name)
    all.select { |item| item.name == name }.first
  end
end

class InterviewMemoryRepository < InterviewRepository
  include InMemory::Repository(DTO::Interview)
end

class RecruiterMemoryRepository < RecruiterRepository
  include InMemory::Repository(DTO::Recruiter)

  def for_month(month)
    all
  end
end

class RoomMemoryRepository < RoomRepository
  include InMemory::Repository(DTO::Room)
end
