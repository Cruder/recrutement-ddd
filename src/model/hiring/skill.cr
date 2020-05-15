module Hiring
  enum Skill
    Java
    Python
    CSharp
    Php
  end

  def self.dto_to_skill(data : DTO::Skill)
    case data.name
    when "java" then Skill::Java
    when "python" then Skill::Python
    when "c#" then Skill::CSharp
    when "php" then Skill::Php
    else raise "Invalid name"
    end
  end

  def self.skill_to_string(skill : Skill)
    case skill
    when Skill::Java then "java"
    when Skill::Python then "python"
    when Skill::CSharp then "c#"
    when Skill::Php then "php"
    end
  end
end
