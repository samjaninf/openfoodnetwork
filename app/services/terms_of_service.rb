# frozen_string_literal: true

class TermsOfService
  def self.tos_accepted?(customer, distributor = nil)
    return false unless accepted_at = customer&.terms_and_conditions_accepted_at

    accepted_at > if distributor
                    distributor.terms_and_conditions_updated_at
                  else
                    TermsOfServiceFile.updated_at
                  end
  end
end
