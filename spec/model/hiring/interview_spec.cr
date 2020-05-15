require "./spec_helper"

Spectator.describe Hiring::Interview do
  context "setup from DTO" do
    subject { described_class.new(data, candidate, recruiter) }

    let(data) { DTO::Interview.new(id: 0, status: "created", booked_date: time_slot) }
    let(time_slot) { DTO::TimeSlot.new(Time.utc, Time.utc) }
    let(candidate) { DTO::Candidate.new(id: 0, name: "Arthur", skills: Array(DTO::Skill).new, availability: time_slot, lvl_skills: 10) }
    let(recruiter) { DTO::Recruiter.new(id: 0, name: "Anthony", skills: Array(DTO::Skill).new, availabilities: [time_slot], lvl_skills: 10) }

    it { is_expected.to be_a(Hiring::Interview) }
  end
end
