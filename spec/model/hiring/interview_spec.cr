require "./spec_helper"

Spectator.describe Hiring::Interview do
  context "setup from DTO" do
    subject { described_class.new(data) }

    let(data) { DTO::Interview.new(id: 0) }

    it { is_expected.to be_a(Hiring::Interview) }
  end
end
