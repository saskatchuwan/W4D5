require 'rails_helper'

#class and instance methods
  #find_by_credentials
  

RSpec.describe User, type: :model do
  subject(:user) {User.new(username: 'liat', password:'password123')}

  describe 'validations' do
    it {should validate_presence_of (:username)}
    it {should validate_presence_of (:password_digest)}
    it {should validate_presence_of (:session_token)}

    it {should validate_uniqueness_of (:session_token)}
    it {should validate_uniqueness_of (:username)}

    it {should validate_length_of (:password).is_at_least(6)}
  end
  
  describe 'associations' do
    it {should have_many(:goals)}
    it {should have_many(:comments)}
  end

  describe '#ensure_session_token' do
    it 'generates session token for user' do
      expect(subject.session_token).to_not be_nil
    end
  end
  
  describe '#is_password?(password)' do
    it 'checks if input password matches user\'s saved password' do
      expect(BCrypt::Password.new(subject.password_digest)).to eq(subject.password)
    end
  end 

  describe '#password=(password)' do
    it 'encrypts the password' do
      expect(BCrypt::Password).to_receive(:create).with(subject.password)
      User.new(username: 'Someuser', password:'password1234')
    end

    it 'doesn\'t persist password to database' do
      subject.save!
      user = User.find_by(username: subject.username)
      expect(user.password).to be_nil
    end
  end

  describe '#reset_session_token!' do
    it 'resets user\'s session token' do
      old_token = subject.session_token
      subject.reset_session_token!
      expect(old_token).to_not eq(subject.session_token)
    end
  end

end
