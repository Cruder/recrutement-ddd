require "./spec_helper"

Spectator.describe Hiring::Recruiter do
  context "setup from DTO" do
    subject { described_class.new(data) }

    let(data) { DTO::Recruiter.new(id: 0, name: "Stan", skills: Array(DTO::Skill).new, availabilities: [DTO::Availability.new(Time.utc, Time.utc)]) }

    it { is_expected.to be_a(Hiring::Recruiter) }
  end
end
