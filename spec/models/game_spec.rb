require "rails_helper"

RSpec.describe Game, type: :model do

  describe "#self.start" do

    let(:p1) { "user_1" }
    let(:p2) { "user_2" }

    before { Array.any_instance.stub(:shuffle).and_return [p1, p2] }

    it 'broadcasts that the game is starting to the players' do
      expect { Game.start(p1, p2) }
        .to have_broadcasted_to("player_#{p1}")
        .with({action:"game_start", msg: "X"})

      expect { Game.start(p1, p2) }
        .to have_broadcasted_to("player_#{p1}")
        .with({action:"game_start", msg: "X"})
    end

    it 'sets the opponents for each on redis' do
      expect(REDIS).to receive(:set).with("opponent_for:#{p1}", p2)
      expect(REDIS).to receive(:set).with("opponent_for:#{p2}", p1)
      Game.start(p1, p2)
    end
  end
end
