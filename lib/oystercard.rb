class Oystercard

  attr_reader :balance
  attr_reader :entry_station

  MAX_VALUE = 90
  MIN_VALUE = 1
  MIN_CHARGE = 1

  def initialize
    @balance = 0
  end

  def top_up(value)
    raise "Exceeds maximum value #{MAX_VALUE}." if value + balance > MAX_VALUE
    @balance += value
  end

  def touch_in(station)
    raise "Not enough balance." if @balance < MIN_VALUE
    p 'On journey'
    @entry_station = station
  end

  def touch_out
    p 'Journey finished'
    deduct(MIN_CHARGE)
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

private

  def deduct(value)
    @balance -= value
  end
end
