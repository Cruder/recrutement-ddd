require "./spec_helper"

Spectator.describe Hiring::Interview do
  context "setup from DTO" do
    subject { described_class.new(data, candidate, recruiter) }

    let(data) { DTO::Interview.new(id: 0, status: "created") }
    let(candidate) { DTO::Candidate.new(id: 0, name: "Arthur", skills: Array(DTO::Skill).new) }
    let(recruiter) { DTO::Recruiter.new(id: 0, name: "Anthony", skills: Array(DTO::Skill).new) }

    it { is_expected.to be_a(Hiring::Interview) }
  end
end
