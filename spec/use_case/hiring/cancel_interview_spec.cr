require "./spec_helper"

Spectator.describe Hiring::CancelInterview do
  double :request do
    stub interview_id
    stub recruiter_id
    stub candidate_id
    stub room_id
  end

  subject { instance.call(request) }

  let(request) { double(:request, interview_id: 1, recruiter_id: 1, candidate_id: 1, room_id: 1) }
  let(instance) { described_class.new(interview_repository, recruiter_repository, candidate_repository, room_repository) }

  let(interview_repository) { InterviewMemoryRepository.new([interview]) }
  let(candidate_repository) { CandidateMemoryRepository.new([candidate]) }
  let(recruiter_repository) { RecruiterMemoryRepository.new([recruiter]) }
  let(room_repository) { RoomMemoryRepository.new([room]) }

  let(interview) { DTO::Interview.new(1, interview_status) }
  let(candidate) { DTO::Candidate.new(1, "Arthur", [skill], availability) }
  let(recruiter) { DTO::Recruiter.new(1, "Mathieu", [skill], [availability]) }
  let(room) { DTO::Room.new(1, "Big room") }

  let(skill) { DTO::Skill.new(1, "java") }
  let(availability) { DTO::Availability.new(Time.utc(2020, 1, 1, 18), Time.utc(2020, 1, 1, 20)) }


  context "with a pending interview" do
    let(interview_status) { "pending" }

    it { is_expected.to be_truthy }
    it "cancels the interview" do
      expect { subject }.to_not change { interview_repository.all.size }
      # expect(interview_repository.find_by_id(1).status).to eq Interview::Status::Canceled
    end
  end

  context "with a scheduled interview" do
    let(interview_status) { "created" }

    it { is_expected.to be_truthy }
    it "cancels the interview" do
      expect { subject }.to change { interview_repository.all.size }
      # expect(interview_repository.find_by_id(1).status).to eq Interview::Status::Canceled
    end
  end
end
