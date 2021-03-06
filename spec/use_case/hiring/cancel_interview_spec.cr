require "./spec_helper"

Spectator.describe Hiring::CancelInterview do
  double :request do
    stub interview_id : Int32
    stub recruiter_id : Int32
    stub candidate_id : Int32
    stub room_id : Int32
  end

  subject { instance.call(request) }

  let(request) { double(:request, interview_id: 1, recruiter_id: 1, candidate_id: 1, room_id: 1) }
  let(instance) { described_class.new(interview_repository, recruiter_repository, candidate_repository, room_repository) }

  let(interview_repository) { InterviewMemoryRepository.new([interview]) }
  let(candidate_repository) { CandidateMemoryRepository.new([candidate]) }
  let(recruiter_repository) { RecruiterMemoryRepository.new([recruiter]) }
  let(room_repository) { RoomMemoryRepository.new([room]) }

  let(interview) { DTO::Interview.new(1, interview_status, booked_date) }
  let(candidate) { DTO::Candidate.new(1, "Arthur", [skill], booked_date, 1) }
  let(recruiter) { DTO::Recruiter.new(1, "Mathieu", [skill], [availability], 5) }
  let(room) { DTO::Room.new(1, "Big room", [booked_date]) }

  let(skill) { DTO::Skill.new(1, "java") }
  let(availability) { DTO::TimeSlot.new(Time.utc(2020, 1, 1, 16), Time.utc(2020, 1, 1, 18)) }
  let(booked_date) { DTO::TimeSlot.new(Time.utc(2020, 1, 1, 18), Time.utc(2020, 1, 1, 20)) }

  context "with a pending interview" do
    let(interview_status) { "pending" }

    it { is_expected.to be_truthy }

    it "cancels the interview and free the recruiter" do
      subject
      expect(interview_repository.all.size).to eq 1
      expect(interview_repository.find_by_id(1).status).to eq "canceled"

      reloaded_recruiter = recruiter_repository.find_by_id(1)
      new_availability = DTO::TimeSlot.new(Time.utc(2020, 1, 1, 16), Time.utc(2020, 1, 1, 20))
      expect(reloaded_recruiter.availabilities).to eq([new_availability])
    end
  end

  context "with a scheduled interview" do
    let(interview_status) { "created" }

    it { is_expected.to be_truthy }

    it "cancels the interview and free the recruiter" do
      subject
      expect(interview_repository.all.size).to eq 1
      expect(interview_repository.find_by_id(1).status).to eq "canceled"

      reloaded_recruiter = recruiter_repository.find_by_id(1)
      new_availability = DTO::TimeSlot.new(Time.utc(2020, 1, 1, 16), Time.utc(2020, 1, 1, 20))
      expect(reloaded_recruiter.availabilities).to eq([new_availability])
    end
  end

  context "with a canceled interview" do
    let(interview_status) { "canceled" }

    it { is_expected.to be_truthy }

    it "cancels the interview and free the recruiter" do
      subject
      expect(interview_repository.all.size).to eq 1
      expect(interview_repository.find_by_id(1).status).to eq "canceled"

      reloaded_recruiter = recruiter_repository.find_by_id(1)
      new_availability = DTO::TimeSlot.new(Time.utc(2020, 1, 1, 16), Time.utc(2020, 1, 1, 20))
      expect(reloaded_recruiter.availabilities).to eq([new_availability])
    end
  end

  context "with a scheduled interview" do
    let(interview_status) { "finished" }

    it { is_expected.to be_truthy }

    it "does not cancel the interview" do
      subject
      expect(interview_repository.all.size).to eq 1
      expect(interview_repository.find_by_id(1).status).to eq "finished"

      reloaded_recruiter = recruiter_repository.find_by_id(1)
      expect(reloaded_recruiter.availabilities).to eq([availability])
    end
  end
end
