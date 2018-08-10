require "rails_helper"

RSpec.describe Seek, type: :model do

  before(:each) { REDIS.flushdb }

  describe "#add" do
    context 'when no other waiting members exist' do
      it 'adds the user to the waitlist' do
        Seek.create "a_user"
        expect(REDIS.smembers("seeks")).to include "a_user"
      end
    end

    context 'when a user is waiting' do
      before(:each) { Seek.create "a_user" }

      it 'starts a new game' do
        expect(Game).to receive(:start).with("another_user", "a_user")
        Seek.create "another_user"
      end

      it 'removes the user from the waiting list' do
        Seek.create "another_user"
        expect(REDIS.smembers("seeks")).to be_empty
      end
    end
  end

  describe "#remove" do
    context 'when member exists in redis' do
      it 'removes the member' do
        Seek.create "a_user"
        Seek.remove "a_user"
        expect(REDIS.smembers("seeks")).to be_empty
      end
    end
  end
end
