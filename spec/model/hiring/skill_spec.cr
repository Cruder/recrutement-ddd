require "./spec_helper"

Spectator.describe Hiring::Skill do

    context "str to enum" do

        subject { Hiring.dto_to_skill(DTO::Skill.new(id: 0, name: skill)) }

        given skill = "java" do
            is_expected.to eq Hiring::Skill::Java
        end

        given skill = "python" do
            is_expected.to eq Hiring::Skill::Python
        end

        given skill = "c#" do
            is_expected.to eq Hiring::Skill::CSharp
        end

        given skill = "php" do
            is_expected.to eq Hiring::Skill::Php
        end
    end

    context "Enum to str" do

        subject { Hiring.skill_to_string(skill) }

        given skill = Hiring::Skill::Java do
            is_expected.to eq "java"
        end

        given skill = Hiring::Skill::Python do
            is_expected.to eq "python"
        end

        given skill = Hiring::Skill::CSharp do
            is_expected.to eq "c#"
        end

        given skill = Hiring::Skill::Php do
            is_expected.to eq "php"
        end
    end

end