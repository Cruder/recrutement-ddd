module Hiring
  class Availability
    protected getter start_at : Time
    protected getter end_at : Time

    def initialize(availability : DTO::Availability)
      initialize(availability.start_at, availability.end_at)
    end

    def initialize(@start_at : Time, @end_at : Time)
      # Verifier un availability not in weekend
      # Heure de debut < heure de fin
      # C'est bien le soir
    end

    def match?(availability : Availability)
      start_at <= availability.start_at &&
        end_at >= availability.end_at
    end
  end
end
