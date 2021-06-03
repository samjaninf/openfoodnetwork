# frozen_string_literal: true

# This class validates if a given payment intent ID is valid in Stripe
module Stripe
  class PaymentIntentValidator
    def call(payment_intent_id, stripe_account_id)
      payment_intent_response = Stripe::PaymentIntent.retrieve(payment_intent_id,
                                                               stripe_account: stripe_account_id)

      raise_if_last_payment_error_present(payment_intent_response)

      payment_intent_response
    end

    private

    def raise_if_last_payment_error_present(payment_intent_response)
      return unless payment_intent_response.respond_to?(:last_payment_error) &&
                    payment_intent_response.last_payment_error.present?

      raise Stripe::StripeError, payment_intent_response.last_payment_error.message
    end
  end
end
