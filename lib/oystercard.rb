class Oystercard

  attr_reader :balance

  MAX_VALUE = 90

  def initialize
    @balance = 0
  end

  def top_up(value)
    raise "Exceeds maximum value #{MAX_VALUE}." if value + balance > MAX_VALUE
    @balance += value
  end
end
