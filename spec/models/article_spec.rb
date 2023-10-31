require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'is valid with valid attributes' do
    article = FactoryBot.create(:article)
    expect(article).to be_valid
  end

  it 'is not valid without an title' do
    article = FactoryBot.build(:article, title: nil)
    expect(article).not_to be_valid
  end

  it 'is not valid without a body' do
    article = FactoryBot.build(:article, body: nil)
    expect(article).not_to be_valid
  end

  it 'is not valid without a status' do
    article = FactoryBot.build(:article, status: nil)
    expect(article).not_to be_valid
  end
end
