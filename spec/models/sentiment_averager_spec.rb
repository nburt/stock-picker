require 'rails_helper'

describe SentimentAverager do

  it 'returns nil if all the scores are nil' do
    expect(SentimentAverager.average!(nil, nil, nil)).to eq(nil)
  end

  it 'takes a title score, description score, and link score, and averages them' do
    expect(SentimentAverager.average!(0, 0.5, 1)).to eq(0.5)
  end

  it 'averages title and description if there is no link score' do
    expect(SentimentAverager.average!(0, 0.5, nil)).to eq(0.25)
  end

  it 'averages title and link if there is no description score' do
    expect(SentimentAverager.average!(0, nil, 0.5)).to eq(0.25)
  end

  it 'averages description and link if there is no title score' do
    expect(SentimentAverager.average!(nil, 0, 0.5)).to eq(0.25)
  end

  it 'handles negative numbers' do
    expect(SentimentAverager.average!(-1, 0, -0.5)).to eq(-0.5)
  end

end