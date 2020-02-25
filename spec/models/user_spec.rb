require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  let!(:user) { create :user }
  let!(:non_author) { create :user }
  let!(:question) { create :question, author: user}
  let!(:answer) { create :answer, question: question, author: user }

  it 'is user an author of the question' do
    expect(user.author?(question)).to be_truthy
  end

  it 'is user an author of the answer' do
    expect(user.author?(answer)).to be_truthy
  end

  it 'user is not an author of the question' do
    expect(non_author.author?(question)).to be_falsey
  end

  it 'user is not an author of the answer' do
    expect(non_author.author?(answer)).to be_falsey
  end

end
