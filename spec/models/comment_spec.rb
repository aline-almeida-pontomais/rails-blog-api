require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @comment = build(:comment, article: build(:article))
  end

  it 'has all the required values' do
    expect(@comment).to be_valid
  end

  it 'has the correct status' do
    expect(@comment.status).to be_in(['public', 'private', 'archived'])
  end

  it 'tests archived method for the comments status' do
    comment = build(:comment, status: 'archived')
    expect(comment.archived?).to be true
  end
end
