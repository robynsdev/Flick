require 'rails_helper'

RSpec.describe Watchlist, type: :model do
  subject {FactoryBot.create(:watchlist)}
  
  context 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a username' do
      subject.user_id = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid without a email' do
      subject.movie_id = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid without a password' do
      subject.title = nil
      expect(subject).to_not be_valid
    end
  end
end