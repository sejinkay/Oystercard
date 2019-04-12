class Station
  attr_reader :name
  attr_reader :zone

  def initialize(name, zone)
    @name = name
    @zone = zone
  end
end

class Oystercard

  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journey_record

  MAX_VALUE = 90
  MIN_VALUE = 1
  MIN_CHARGE = 1

  def initialize
    @balance = 0
    @journey_record = []
  end

  def top_up(value)
    raise "Exceeds maximum value #{MAX_VALUE}." if value + balance > MAX_VALUE
    @balance += value
  end

  def touch_in(station)
    raise "Not enough balance." if @balance < MIN_VALUE
    p 'On journey'
    @exit_station = nil
    @entry_station = station
  end

  def touch_out(station)
    p 'Journey finished'
    deduct(MIN_CHARGE)
    @exit_station = station
    add_journey
    @entry_station = nil
  end

  def add_journey
    journey = { :entry => entry_station, :exit => exit_station }
    @journey_record << journey
  end

  def in_journey?
    !!entry_station
  end

private

  def deduct(value)
    @balance -= value
  end
end
