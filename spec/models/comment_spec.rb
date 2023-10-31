require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'is valid with valid attributes' do
    comment = FactoryBot.create(:comment)
    expect(comment).to be_valid
  end

  it 'is not valid without an commenter' do
    comment = FactoryBot.build(:comment, commenter: nil)
    expect(comment).not_to be_valid
  end

  it 'is not valid without a body' do
    comment = FactoryBot.build(:comment, body: nil)
    expect(comment).not_to be_valid
  end

  it 'is not valid without a status' do
    comment = FactoryBot.build(:comment, status: nil)
    expect(comment).not_to be_valid
  end
end
