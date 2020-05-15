require "./spec_helper"

Spectator.describe Hiring::Room do
  context "setup from DTO" do
    subject { described_class.new(data) }

    let(data) { DTO::Room.new(id: 0, name: "Orange", booked_dates: [DTO::Availability.new(Time.utc, Time.utc)]) }

    it { is_expected.to be_a(Hiring::Room) }
  end
end
