require "./spec_helper"

Spectator.describe Hiring::TimeSlot do
  describe ".split_with" do
    subject { described_class.split_with(actual, busy) }

    let(actual) { described_class.new(Time.utc(2020, 1, 10, 10), Time.utc(2020, 1, 10, 13)) }
    let(busy) { described_class.new(Time.utc(2020, 1, 10, 11), Time.utc(2020, 1, 10, 12)) }

    it do
      is_expected.to eq({
        described_class.new(Time.utc(2020, 1, 10, 10), Time.utc(2020, 1, 10, 11)),
        described_class.new(Time.utc(2020, 1, 10, 12), Time.utc(2020, 1, 10, 13)),
      })
    end
  end

  describe ".remerge" do
    subject { described_class.remerge(time_slots) }

    context "one time slot" do
      let(time_slots) { [Hiring::TimeSlot.new(Time.utc, Time.utc)] }

      it { is_expected.to eq(time_slots) }
    end

    context "two time slot with end and start equal" do
      let(time_slots) { [
        Hiring::TimeSlot.new(Time.utc(2020, 1, 13, 10), Time.utc(2020, 1, 15, 14)),
        Hiring::TimeSlot.new(Time.utc(2020, 1, 15, 14), Time.utc(2020, 1, 17, 16)),
      ] }
      it { is_expected.to eq([Hiring::TimeSlot.new(Time.utc(2020, 1, 13, 10), Time.utc(2020, 1, 17, 16))]) }
    end

    context "three time slot with end and start equal" do
      let(time_slots) { [
        Hiring::TimeSlot.new(Time.utc(2020, 1, 13, 10), Time.utc(2020, 1, 15, 16)),
        Hiring::TimeSlot.new(Time.utc(2020, 1, 15, 16), Time.utc(2020, 1, 16, 17)),
        Hiring::TimeSlot.new(Time.utc(2020, 1, 16, 17), Time.utc(2020, 1, 17, 6)),
      ] }
      it { is_expected.to eq([Hiring::TimeSlot.new(Time.utc(2020, 1, 13, 10), Time.utc(2020, 1, 17, 6))]) }
    end

    context "three time slot with different timeslot remarge before" do
      let(time_slots) { [
        Hiring::TimeSlot.new(Time.utc(2020, 1, 13, 17), Time.utc(2020, 1, 15, 16)),
        Hiring::TimeSlot.new(Time.utc(2020, 1, 17, 14), Time.utc(2020, 1, 20, 12)),
        Hiring::TimeSlot.new(Time.utc(2020, 1, 20, 12), Time.utc(2020, 1, 22, 15)),
      ] }
      it { is_expected.to eq([
        Hiring::TimeSlot.new(Time.utc(2020, 1, 13, 17), Time.utc(2020, 1, 15, 16)),
        Hiring::TimeSlot.new(Time.utc(2020, 1, 17, 14), Time.utc(2020, 1, 22, 15)),
      ]) }
    end

    context "three time slot with different timeslot remarge after" do
      let(time_slots) { [
        Hiring::TimeSlot.new(Time.utc(2020, 1, 13, 10), Time.utc(2020, 1, 17, 12)),
        Hiring::TimeSlot.new(Time.utc(2020, 1, 17, 12), Time.utc(2020, 1, 20, 12)),
        Hiring::TimeSlot.new(Time.utc(2020, 1, 24, 17), Time.utc(2020, 1, 27, 18)),
      ] }
      it { is_expected.to eq([
        Hiring::TimeSlot.new(Time.utc(2020, 1, 13, 10), Time.utc(2020, 1, 20, 12)),
        Hiring::TimeSlot.new(Time.utc(2020, 1, 24, 17), Time.utc(2020, 1, 27, 18)),
      ]) }
    end
  end

  describe "#initialize" do
    context "from DTO" do
      subject { described_class.new(data) }
      let(data) { DTO::TimeSlot.new(start_at, end_at) }

      context "nominal case" do
        let(start_at) { Time.utc(2020, 1, 10, 10) }
        let(end_at) { Time.utc(2020, 1, 10, 11) }

        it { is_expected.to be_a(Hiring::TimeSlot) }
      end

      context "starts on weekend" do
        let(start_at) { Time.utc(2020, 1, 11, 10) }
        let(end_at) { Time.utc(2020, 1, 14, 11) }

        it { expect { subject }.to raise_error }
      end

      context "ends on weekend" do
        let(start_at) { Time.utc(2020, 1, 10, 10) }
        let(end_at) { Time.utc(2020, 1, 11, 11) }

        it { expect { subject }.to raise_error }
      end

      context "start after end" do
        let(end_at) { Time.utc(2020, 1, 10, 10) }
        let(start_at) { Time.utc(2020, 1, 10, 11) }

        it { expect { subject }.to raise_error }
      end
    end

    context "from dates" do
      subject { described_class.new(start_at, end_at) }

      context "nominal case" do
        let(start_at) { Time.utc(2020, 1, 10, 10) }
        let(end_at) { Time.utc(2020, 1, 10, 11) }

        it { is_expected.to be_a(Hiring::TimeSlot) }
      end

      context "starts on weekend" do
        let(start_at) { Time.utc(2020, 1, 11, 10) }
        let(end_at) { Time.utc(2020, 1, 14, 11) }

        it { expect { subject }.to raise_error }
      end

      context "ends on weekend" do
        let(start_at) { Time.utc(2020, 1, 10, 10) }
        let(end_at) { Time.utc(2020, 1, 11, 11) }

        it { expect { subject }.to raise_error }
      end

      context "start after end" do
        let(end_at) { Time.utc(2020, 1, 10, 10) }
        let(start_at) { Time.utc(2020, 1, 10, 11) }

        it { expect { subject }.to raise_error }
      end
    end
  end

  describe "#match?" do
    subject { time_slot.match?(variant) }

    let(time_slot) { Hiring::TimeSlot.new(Time.utc(2020, 1, 10, 10), Time.utc(2020, 1, 10, 18)) }

    context "included inside" do
      let(variant) { Hiring::TimeSlot.new(Time.utc(2020, 1, 10, 12), Time.utc(2020, 1, 10, 14)) }

      it { is_expected.to be_truthy }
    end

    context "with start before" do
      let(variant) { Hiring::TimeSlot.new(Time.utc(2020, 1, 10, 9), Time.utc(2020, 1, 10, 14)) }

      it { is_expected.to be_falsey }
    end

    context "with end after" do
      let(variant) { Hiring::TimeSlot.new(Time.utc(2020, 1, 10, 12), Time.utc(2020, 1, 10, 19)) }

      it { is_expected.to be_falsey }
    end
  end
end
