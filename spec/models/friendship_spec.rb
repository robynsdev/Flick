require 'rails_helper'

RSpec.describe Friendship, type: :model do
  subject {FactoryBot.create(:friendship)}
  
  context 'validations' do
    it 'is valid with valid attributes' do
      p subject
      expect(subject).to be_valid
    end

    it 'is not valid without a user_id' do
      subject.user_id = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid without a friend_id' do
      subject.friend_id = nil
      expect(subject).to_not be_valid
    end
  end
end