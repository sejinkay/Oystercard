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
    it 'deducts value from the balance' do
      expect{ subject.deduct 5 }. to change{ subject.balance }.by -5
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
    it 'when user touches in they are on in journey' do
      expect(subject.touch_in).to eq true
    end

    it 'when user touches out they have finished journey' do
      expect(subject.touch_out).to eq false
    end

    it { is_expected.to respond_to :in_journey? }

    it 'checks if user is in journey?' do
      subject.touch_in
      expect(subject).to be_in_journey
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

  end
end
