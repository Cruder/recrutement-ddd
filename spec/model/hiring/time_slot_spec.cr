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
