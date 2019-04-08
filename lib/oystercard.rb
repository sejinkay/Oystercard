class Oystercard

  attr_reader :balance

  MAX_VALUE = 90

  def initialize
    @balance = 0
    @status = false
  end

  def top_up(value)
    raise "Exceeds maximum value #{MAX_VALUE}." if value + balance > MAX_VALUE
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def touch_in
    p 'On journey'
    @status = true
  end

  def touch_out
    p 'Journey finished'    
    @status = false
  end

  def in_journey?
    @status
  end
end
