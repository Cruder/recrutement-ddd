require "./spec_helper"

Spectator.describe Hiring::Recruiter do
  context "setup from DTO" do
    subject { described_class.new(data) }

    let(data) { DTO::Recruiter.new(id: 0, name: "Stan") }

    it { is_expected.to be_a(Hiring::Recruiter) }
  end
end
