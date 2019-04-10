class Oystercard

  attr_reader :balance

  MAX_VALUE = 90
  MIN_VALUE = 1

  def initialize
    @balance = 0
    @status = false
  end

  def top_up(value)
    raise "Exceeds maximum value #{MAX_VALUE}." if value + balance > MAX_VALUE
    @balance += value
  end

  def touch_in
    raise "Not enough balance." if @balance < MIN_VALUE
    p 'On journey'
    @status = true
  end

  def touch_out
    p 'Journey finished'
    deduct(1)
    @status = false
  end

  def in_journey?
    @status
  end

private

  def deduct(value)
    @balance -= value
  end
end
