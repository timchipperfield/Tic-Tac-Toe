require "rails_helper"

RSpec.describe Waitlist, type: :model do

  before(:each) { REDIS.flushdb }

  describe "#add" do
    context 'when no other waiting members exist' do
      it 'adds the user to the waitlist' do
        Waitlist.add "a_user"
        expect(REDIS.smembers("waiting")).to include "a_user"
      end
    end

    context 'when a user is waiting' do
      before(:each) { Waitlist.add "a_user" }

      it 'starts a new game' do
        expect(Game).to receive(:start).with("another_user", "a_user")
        Waitlist.add "another_user"
      end

      it 'removes the user from the waiting list' do
        Waitlist.add "another_user"
        expect(REDIS.smembers("waiting")).to be_empty
      end
    end
  end

  describe "#remove" do
    context 'when member exists in redis' do
      it 'removes the member' do
        Waitlist.add "a_user"
        Waitlist.remove "a_user"
        expect(REDIS.smembers("waiting")).to be_empty
      end
    end
  end
end
