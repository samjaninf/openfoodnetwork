Money.rounding_mode = BigDecimal::ROUND_HALF_EVEN
Money.default_currency = Money::Currency.new(ENV.fetch('CURRENCY'))
