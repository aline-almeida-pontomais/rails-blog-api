require 'rails_helper'

RSpec.describe Article, type: :model do

  it 'has all the required values' do
    article = build(:article)
    expect(article).to be_valid
  end

  it 'has not all the required values' do
    status = FFaker::BaconIpsum.phrase
    title = FFaker::BaconIpsum.phrase

    article = Article.create(status: status, title: title)
    expect(article).to_not be_valid
  end

  it 'returns the correct title' do
    title = FFaker::BaconIpsum.phrase
    article = Article.create(title: title)
    expect(article.title).to eq("#{title}")
  end

  it 'is valid if body length is greater than 10' do
    article = build(:article)
    expect(article.body.length).to be > 10
  end

  it 'has the correct status' do
    article = build(:article)
    expect(article.status).to be_in(['public', 'private', 'archived'])
  end

  it 'tests archived method for the article status' do
    article = build(:article, status: 'archived')
    expect(article.archived?).to be true
  end
end
