require "./spec_helper"

Spectator.describe Hiring::ScheduleInterview do
  subject { instance.call(request) }

  let(request) { FakeRequest.new(candidate_id) }
  let(instance) { described_class.new(interview_repository, candidate_repository, recruiter_repository, room_repository) }

  let(interview_repository) { InterviewMemoryRepository.new }
  let(candidate_repository) { CandidateMemoryRepository.new([candidate]) }
  let(recruiter_repository) { RecruiterMemoryRepository.new([skillfull_recruiter, java_recruiter, python_recruiter]) }
  let(room_repository) { RoomMemoryRepository.new([room]) }

  let(candidate) { DTO::Candidate.new(candidate_id, "Arthur", [skill_java, skill_python], availability_2, 9) }
  let(candidate_id) { 0 }

  let(skill_java) { DTO::Skill.new(1, "java") }
  let(skill_python) { DTO::Skill.new(1, "python") }

  let(skillfull_recruiter) do
    DTO::Recruiter.new(1, "Mathieu", [skill_java, skill_python], [availability_1, availability_2], 10)
  end

  let(java_recruiter) do
    DTO::Recruiter.new(2, "Vincent", [skill_java], [availability_1, availability_3], 10)
  end

  let(python_recruiter) do
    DTO::Recruiter.new(3, "Thomas", [skill_python], [availability_2, availability_3], 10)
  end

  let(room) { DTO::Room.new(1, "Big room", [availability_1]) }

  let(availability_1) { DTO::TimeSlot.new(Time.utc(2020, 1, 1, 18), Time.utc(2020, 1, 1, 20)) }
  let(availability_2) { DTO::TimeSlot.new(Time.utc(2020, 1, 2, 17), Time.utc(2020, 1, 2, 20)) }
  let(availability_3) { DTO::TimeSlot.new(Time.utc(2020, 1, 3, 17), Time.utc(2020, 1, 3, 20)) }

  context "with a java candidate" do
    it { is_expected.to be_truthy }

    it "adds an interview and book a room" do
      expect { subject }.to change { interview_repository.all.size }.by(1)

      interview = interview_repository.all.last
      expect(interview.status).to eq "pending"
      expect(interview.booked_date).to eq availability_2

      room = room_repository.all.last
      expect(room.booked_dates).to eq [availability_1, availability_2]

      recruiter = recruiter_repository.find_by_id(1)
      expect(recruiter.availabilities).to eq [availability_1]
    end
  end

  context "without an available room" do
    let(room) { DTO::Room.new(1, "Big room", [availability_2]) }

    it "does not add an interview or book a room" do
      subject
      expect(interview_repository.all.size).to eq 0

      room = room_repository.all.last
      expect(room.booked_dates).to eq [availability_2]

      recruiter = recruiter_repository.find_by_id(1)
      expect(recruiter.availabilities).to eq [availability_1, availability_2]
    end
  end
end
