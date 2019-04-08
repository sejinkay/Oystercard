require 'oystercard'

describe Oystercard do
  it 'checks the card balance returns 0' do
    expect(subject.balance).to eq 0
  end
end
