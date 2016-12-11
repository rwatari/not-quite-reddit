require 'rails_helper'
require 'spec_helper'

describe User do
  let!(:user) { User.create!(username: 'test', password: 'password') }

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'associations' do
    it { should have_many(:subs) }
    it { should have_many(:votes) }
    it { should have_many(:comments) }
  end

  describe '::find_by_credentials' do
    it 'returns nil if the username is incorrect' do
      search_result = User.find_by_credentials('testing', 'password')
      expect(search_result).to be_nil
    end

    it 'returns nil if the password is incorrect' do
      search_result = User.find_by_credentials('test', 'passwod')
      expect(search_result).to be_nil
    end

    it 'returns the user if the credentials are correct' do
      search_result = User.find_by_credentials('test', 'password')
      expect(search_result).to eq(user)
    end
  end

  describe '#is_password?' do
    it 'returns false if the password is incorrect' do
      expect(user.is_password?('hello world')).to eq(false)
    end

    it 'returns true if the password is correct' do
      expect(user.is_password?('password')).to eq(true)
    end
  end

  describe '#reset_session_token!' do
    it 'modifies the session token' do
      old_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).not_to eq(old_token)
    end

    it 'persists changes to the database' do
      user.reset_session_token!
      new_token = User.where(id: user.id).pluck(:session_token).first
      expect(user.session_token).to eq(new_token)
    end
  end
end
