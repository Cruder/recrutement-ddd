require "./spec_helper"

Spectator.describe Hiring::ScheduleInterview do
  subject { instance.call(request) }

  let(request) { FakeRequest.new(candidate_id) }
  let(instance) { described_class.new(interview_repository, candidate_repository, recruiter_repository, room_repository) }

  let(interview_repository) { InterviewMemoryRepository.new }
  let(candidate_repository) { CandidateMemoryRepository.new }
  let(recruiter_repository) { RecruiterMemoryRepository.new }
  let(room_repository) { RoomMemoryRepository.new }

  let(candidate_id) { 0 }

  context "with a java candidate" do
    it { is_expected.to be_truthy }
    it "adds an interview" do
      expect { subject }.to change { interview_repository.all.size }.by(1)
    end
  end
end
