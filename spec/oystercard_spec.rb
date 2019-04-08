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
end
