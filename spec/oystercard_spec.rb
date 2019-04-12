require 'oystercard'

describe Oystercard do
  it 'checks the card balance returns 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'adds value to the balance' do
      expect{ subject.top_up 5 }.to change{ subject.balance }.by 5
    end
    it 'adds value to the balance' do
      expect{ subject.top_up 15 }.to change{ subject.balance }.by 15
    end
  end

  describe '#deduct' do
    let(:station){ double :station }
    it 'deducts the fare when touch_out' do
      subject.top_up(5)
      subject.touch_in(station)
      expect{ subject.touch_out(station)}.to change{ subject.balance }.by -(Oystercard::MIN_CHARGE)
    end
  end

  describe 'maximum value' do
    it 'raise an error if top up value exceeds max value' do
      maximum_balance = Oystercard::MAX_VALUE
      subject.top_up(maximum_balance)
      expect{ subject.top_up 1 }.to raise_error "Exceeds maximum value #{maximum_balance}."
    end
  end

    describe '#touch_in' do
      let(:station){ double :station }

      it 'raise an error if theres not enough balance' do
        minimum_balance = Oystercard::MIN_VALUE
        expect{ subject.touch_in(station) }.to raise_error "Not enough balance."
      end
    end
  end

describe Journey do

  let(:station){ double :station }
  let(:card){ double :card }

  it 'has an empty list of journeys' do
    expect(subject.journey_record).to be_empty
  end

  describe "#touch_in" do
    it 'stores the entry station' do
      allow(card).to receive (:top_up) { 20 }
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end

  describe "#touch_out" do
    it 'saves exit station' do
      subject.touch_out(station)
      expect(subject.exit_station).to eq station
    end
  end


  describe '#add_journey' do
    it 'stores a journey' do
      allow(card).to receive (:top_up) { 20 }
      subject.touch_in(station)
      subject.touch_out(station)
      expect{ subject.add_journey }.to change {subject.journey_record.count}.by(1)
    end
  end

  it { is_expected.to respond_to :in_journey? }

end

describe Station do
  subject { described_class.new("Angel", 1)}

  it 'checks if there\'s name' do
  expect(subject.name).to eq "Angel"
  end

  it 'checks if there\'s zone' do
  expect(subject.zone).to eq 1
  end
end
