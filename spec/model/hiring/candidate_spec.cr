require "./spec_helper"

Spectator.describe Hiring::Candidate do
  context "setup from DTO" do
    subject { described_class.new(data) }

    let(data) { DTO::Candidate.new(id: 0, name: "Arthur", skills: Array(DTO::Skill).new, availability: DTO::TimeSlot.new(Time.utc, Time.utc), lvl_skills: 9) }

    it { is_expected.to be_a(Hiring::Candidate) }
  end
end
