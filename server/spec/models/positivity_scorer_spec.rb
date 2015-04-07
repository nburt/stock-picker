require 'rails_helper'

describe PositivityScorer do

  it 'takes an array of keywords and a sentiment score and generates a positivity score' do
    keywords = [
      {
        text: "earnings forecast",
        relevance: "0.952074",
        sentiment: {score: -0.677091, type: "negative"}
      }
    ]

    sentiment = {
      score: -0.544381,
      type: "negative"
    }

    score = PositivityScorer.score!(keywords, sentiment)
    # Weighted average = -0.5886176667
    # 41.14 / 200 * 100 = 20.57
    expect(score < 25).to eq(true)
  end

  it 'can score a sentiment that is a mixture of positive and negative' do
    keywords = [
      {
        text: "earnings forecast",
        relevance: "0.952074",
        sentiment: {score: -0.677091, type: "negative"}
      },
      {
        text: "other earnings forecast",
        relevance: "0.902074",
        sentiment: {score: 0.65873, type: "negative"}
      }
    ]

    sentiment = {
      score: 0,
      type: "neutral"
    }

    score = PositivityScorer.score!(keywords, sentiment)
    # Weighted average = -0.0091805
    # (-0.91805 + 100) / 200 * 100 = 49.54
    expect(score < 50).to eq(true)
  end

  it 'can score sentiment that is positive' do
    keywords = [
      {
        text: "earnings forecast",
        relevance: "0.952074",
        sentiment: {score: 0.677091, type: "negative"}
      }
    ]

    sentiment = {
      score: 0.544381,
      type: "negative"
    }

    score = PositivityScorer.score!(keywords, sentiment)
    # Weighted average = 0.5886176667
    # 58.86 + 100 / 200 = 79.43
    expect(score > 75).to eq(true)
  end

end