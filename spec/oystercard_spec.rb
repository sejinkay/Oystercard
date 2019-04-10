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
      expect{ subject.touch_out}.to change{ subject.balance }.by -(Oystercard::MIN_CHARGE)
    end
  end

  describe 'maximum value' do
    it 'raise an error if top up value exceeds max value' do
      maximum_balance = Oystercard::MAX_VALUE
      subject.top_up(maximum_balance)
      expect{ subject.top_up 1 }.to raise_error "Exceeds maximum value #{maximum_balance}."
    end
  end

  describe 'journey status' do

    describe '#touch_in' do
      let(:station){ double :station }

      it 'checks if user is in journey?' do
        subject.top_up(5)
        subject.touch_in(station)
        expect(subject).to be_in_journey
        subject.touch_out
        expect(subject).not_to be_in_journey
      end

      it 'stores the entry station' do
        subject.top_up(5)
        subject.touch_in(station)
        expect(subject.entry_station).to eq station
      end

      it 'raise an error if theres not enough balance' do
        minimum_balance = Oystercard::MIN_VALUE
        expect{ subject.touch_in(station) }.to raise_error "Not enough balance."
      end
    end

    it { is_expected.to respond_to :in_journey? }

  end
end
