require "./repository"

abstract class ReportRepository
  alias Model = DTO::Report

  include Repository(Model)

  abstract def add(report : Model)
end
