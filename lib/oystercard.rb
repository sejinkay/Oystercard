class Station
  attr_reader :name
  attr_reader :zone

  def initialize(name, zone)
    @name = name
    @zone = zone
  end
end

class Journey

  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journey_record

  def initialize
    @journey_record = []
  end

  def add_journey
    journey = { :entry => entry_station, :exit => exit_station }
    @journey_record << journey
  end

  def touch_in(station)
    @exit_station = nil
    @entry_station = station
  end

  def touch_out(station)
    @exit_station = station
    add_journey
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

end

class Oystercard

  attr_reader :balance

  MAX_VALUE = 90
  MIN_VALUE = 1
  MIN_CHARGE = 1

  def initialize
    @balance = 0
    @journey
  end

  def top_up(value)
    raise "Exceeds maximum value #{MAX_VALUE}." if value + balance > MAX_VALUE
    @balance += value
  end

  def touch_in(station)
    raise "Not enough balance." if @balance < MIN_VALUE
    @journey = Journey.new
    @journey.touch_in(station)
  end

  def touch_out(station)
    deduct(MIN_CHARGE)
    @journey.touch_out(station)
  end

  def fare
    MIN_CHARGE
  end

private

  def deduct(value)
    @balance -= value
  end
end
