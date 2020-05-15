require "./spec_helper"

Spectator.describe Hiring::Recruiter do
  context "setup from DTO" do
    subject { described_class.new(data) }

    let(data) { DTO::Recruiter.new(id: 0, name: "Stan", skills: Array(DTO::Skill).new, availabilities: [DTO::Availability.new(Time.utc, Time.utc)]) }

    it { is_expected.to be_a(Hiring::Recruiter) }
  end
  describe "#match?" do
    subject { recruiter.match? candidate }

    let(recruiter) { Hiring::Recruiter.new DTO::Recruiter.new(id: 0, name: "Thomas", skills: recruiter_skills, availabilities: recruiter_availabilities) }
    let(candidate) { Hiring::Candidate.new DTO::Candidate.new(id: 0, name: "Vincent", skills: candidate_skills, availability: candidate_availability) }
    context "match with candidate avaibility" do
      let(recruiter_skills) { Array(DTO::Skill).new }
      let(recruiter_availabilities) { [DTO::Availability.new(Time.utc(2020, 1, 1, 14), Time.utc(2020, 1, 1, 15))] }

      let(candidate_skills) { Array(DTO::Skill).new }
      let(candidate_availability) { DTO::Availability.new(Time.utc(2020, 1, 1, 14), Time.utc(2020, 1, 1, 14, 15)) }

      it {
        is_expected.to be_truthy
      }
    end

    context "match with candidate skills" do
      let(time) { DTO::Availability.new(Time.utc, Time.utc) }

      let(recruiter_skills) { [DTO::Skill.new(0, "php"), DTO::Skill.new(1, "c#")] }
      let(recruiter_availabilities) { [time] }

      let(candidate_skills) { [DTO::Skill.new(0, "php"), DTO::Skill.new(1, "c#")] }
      let(candidate_availability) { time }

      it {
        is_expected.to be_truthy
      }
    end

    context "match with candidate skill when have more" do
      let(time) { DTO::Availability.new(Time.utc, Time.utc) }

      let(recruiter_skills) { [DTO::Skill.new(0, "php"), DTO::Skill.new(1, "c#")] }
      let(recruiter_availabilities) { [time] }

      let(candidate_skills) { [DTO::Skill.new(0, "php")] }
      let(candidate_availability) { time }

      it {
        is_expected.to be_truthy
      }
    end

    context "not match with candidate skills" do
      let(time) { DTO::Availability.new(Time.utc, Time.utc) }

      let(recruiter_skills) { [DTO::Skill.new(0, "php")] }
      let(recruiter_availabilities) { [time] }

      let(candidate_skills) { [DTO::Skill.new(0, "php"), DTO::Skill.new(1, "c#")] }
      let(candidate_availability) { time }

      it {
        is_expected.to be_falsey
      }
    end
  end
end
